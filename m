Return-Path: <netdev+bounces-220304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A604B4558F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3321A01733
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A6322539;
	Fri,  5 Sep 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie3zTAk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1732144D;
	Fri,  5 Sep 2025 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069652; cv=none; b=XWjOWskampGoEqp74i73b88fdgd7DFu+4wJVkxYWxpdJskwPoi4AUmyaeQFJkMjUwu1IMDRSSccuiZn6+OwimgMVMdkQl85Kg2esETaMluh7o/ZlXOjQOqo3mdUYdqsCM+gm8pKxjLHil+qDj6HijER32fk6bEf/6MLuQq2n8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069652; c=relaxed/simple;
	bh=HfX44cCVxvlSHiCbNobCW//1cotLxhGdfKz5wHzdISw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=swZk01yILvdcamDD/AmINIEpUdLzCzKDD6xTas3M9rGM9hU8RPPnlL7sazOPZ8ycxHRAuNYQ71kG3SCBkmM2X19aN1VfsKu8l4RA5t9v80RRlgJeoAFZci/lSJjDZdAi5y6yz46AqQEDXERzf4b7ePujC0r6bJCOjO97KvTlHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie3zTAk7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df35a67434so1133163f8f.3;
        Fri, 05 Sep 2025 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069649; x=1757674449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfX44cCVxvlSHiCbNobCW//1cotLxhGdfKz5wHzdISw=;
        b=Ie3zTAk7NP+5BxQY0ci73Ho9pbdvQnLi7L3YvcaTVkWLyZi8Pc76NwLTkZSLgSzbOn
         CtquNQvax+YWQNiGty4iGhgZMbyS60u7DHAzfKbjgHwQ1cCbrYK2L7P81lrhmiMsXLbk
         sTJ+Cw/i3uL6Vi7QU+RcUZhmfhGZsvLPOLS8fB6+it8eHon2MCIIN3slWsytg9xA0Mbz
         l+h2IBcJU00/rL6GiNG3FjomsPS0BHy7W5CRVm05H4mSYOHUevveBPCghS7Hjk2oT5M6
         PXoUWBAA0M9gIx0CM9R2CyA/g3UOpVuNK6r/j2qaigx/mGDDB/b0saSD8IbuPpu73ETh
         t0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069649; x=1757674449;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfX44cCVxvlSHiCbNobCW//1cotLxhGdfKz5wHzdISw=;
        b=faSV2JyFUaO4UJD7vGZn3Ce2x96JtE/eXotYedcEB8LMccs3BDJRfQ31qTjgHlGpPK
         a5ogHlO7ecqkX00wO4D9XpcEPvDOx9moHARRgYnAqpZTLF5usVlR6bnjeRnGuyxEv0Ss
         hHppeWnPRBC8Vdnesz5/fdzS2WB+EEcengxCYNDquABv3L6hWboZntj0FLc5YiFeR3C7
         3pBD9HaiOf844s3QiyhWzLAaHY7ueHrE0+lB+ESrVC1O6cAF5I0m8k6AhgJPjssWeHX2
         h8Ketm7N2a8RdzHVc83KZNBrDaWFUQqj4vq0S2TB8SKUMiRJwRiC2CZ8TNjzJZLllEU3
         kb8w==
X-Forwarded-Encrypted: i=1; AJvYcCUzPcqXnk4yUD2k4FNKg5+E7TAN7TSjoGVLSmchJRMD6i6mQyKR/U/6ILQaJ91YvWcmYiGCO4ei@vger.kernel.org, AJvYcCVLStOhLNH+AEll6aJq1uQ5T+IPtG/8LJpWH1ZuyvDsJ90bW5YZktWKrIUp9XnQ1T96MkYTlKP0Tab/62U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwdk+HvSb6mA7q4zXG9vxuWEwY6evGq4YH1/1QzJVci/UEN/6+
	YMmdzASYy3DzqAvLT6PKvmCGqeG2OulQChs8A2dTJ1XxaEFCoT7A3Q5FgLYVBiFm
X-Gm-Gg: ASbGncuCtNkpcOAkutMZx6w7nv8IkPTvaijr7JsuBj++TrNdzXn/b2JqWlnC2nc0aNz
	g37C+PLNoWln1K/pxeIl2HXAnwCzBNqcsguJNz+BAuFENbOaXNjhohU6qwPdw14AKPdY1xEovIn
	oQMt+/mORQAsNU/98DBgb0NT/mC1NaLjlYZOpqA8fsJeNr0Pq1ISNNumlvzvqbE9UtESjKEjpvw
	QgEn9YRmHJ3of42I1S0vFKz/urf/mwDukEdqRGM2+8ZbfMIBd5t4lXenCwqYhvOVJBLqFlQ+hyo
	dsUILEpSYY3ExxsfSshvnb1dPVWzZ50XlfsPDl3PsPTpZoA8vK2cuxJJViL8DT7rHFcS2B8F7Hp
	XCtnuW9lz9erUSzsBEihbveEPoeCcC3XllDfwfYNSyNgYEA==
X-Google-Smtp-Source: AGHT+IFr36RJW7E2yGF/wK6VOECemQL0w3KvaSXVwzVEKkJL8YL3TLKGhXqDsUzljxD7JqPtJ74H6A==
X-Received: by 2002:a05:6000:250e:b0:3c8:c89d:6b5b with SMTP id ffacd0b85a97d-3d1e01d2f18mr17441129f8f.48.1757069649105;
        Fri, 05 Sep 2025 03:54:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d9f3c36a78sm15388611f8f.48.2025.09.05.03.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] tools: ynl: add ipv4-or-v6 display hint
In-Reply-To: <20250904220156.1006541-11-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:53:46 +0100
Message-ID: <m2cy85xj9h.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-11-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> The attribute WGALLOWEDIP_A_IPADDR can contain either an IPv4
> or an IPv6 address depending on WGALLOWEDIP_A_FAMILY, however
> in practice it is enough to look at the attribute length.
>
> This patch implements an ipv4-or-v6 display hint, that can
> deal with this kind of attribute.
>
> It only implements this display hint for genetlink-legacy, it
> can be added to other protocol variants if needed, but we don't
> want to encourage it's use.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

I suspect there are occurrences of ipv4 or ipv6 in the existing specs
that really should be ipv4-or-ipv6 but the python code doesn't care.

