Return-Path: <netdev+bounces-219505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9570B419E5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2548316EC24
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C22F28FC;
	Wed,  3 Sep 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9pufOPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF62F1FC0;
	Wed,  3 Sep 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891561; cv=none; b=u3kRKoABpG/Hw7F8K+xH3KX/AuHAgCtD4txs5KfY5YjR7CR3vAic+OmeayPLUEgC4Ndqm9gtxGjCF6DDGTKZgoUu3rPNIsGg2COCCqjAr+udtiHv819rl75Cx+p5ipcTe/1WAQObrrW45UsVdfWvLta1nGpxmX97mTc0jYeCb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891561; c=relaxed/simple;
	bh=59iraut11ydwf19KgWFacNPvjuTlEHsS6RhQ76in5nc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=JlPIWZmSnA6BYsCuFaJk7gUyu4nRv0rCa9/Q5n9+2RDRANd5+1rJI+fXqQndO8W6oBplA9V5ZD0QjavarkLuAh1Hsw+UDZS/zQBKLinzIY5XSn1JlFVCO1rxOXNkMo3vYmWfEdPbUaddnJ8VB0/P8LL9+9MWTQIY/Jen5j5EOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9pufOPj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so23237555e9.2;
        Wed, 03 Sep 2025 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756891558; x=1757496358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59iraut11ydwf19KgWFacNPvjuTlEHsS6RhQ76in5nc=;
        b=J9pufOPjj0ty5QDtiENqVkDOV2/86JyUQllY1nPFrRvHASdiY2OFfsl1fGNSl5ewIw
         utmza6cyZ3xEopp06q9YHoUZmZe89iZmk+Wh4r/jUEg6I4dGuTJcbs64xqC0qrwzfNq5
         gtROXgZ3t5Tv9g5r3kPQ2rN05BwFooA56AypgeNqzhH9j66YpeJA7sbrhG1/htrZbgqG
         Gd78grNNhuqmCkFG42GiunD1wnvESJZWa8HaaxL+muokhtWG/7cTKdRFo38tUUs/Egw4
         oz0ODehzPWK2NuFe4Zxscc1B4LBgdRy6zw2yoCJiaa1Lzrup6tOX0iC2F8geIqj/pWce
         jtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891558; x=1757496358;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59iraut11ydwf19KgWFacNPvjuTlEHsS6RhQ76in5nc=;
        b=jGk8J5ZfqOjRr+bxUtK6hZEgBFiOuT3kWU2/WK4VY0MvUrd84yUMxjXg1N0r5UjLWr
         jFwhpXXeE98j+mRz2Lje/PRPM9rCQHf3HzPmBD4SC3ik0qZOoMnMTIotMoCt+pPdg6lG
         SbOSqqFe1ZlbglV68iXUH4RvmcT/sgAmKyVI5kQd/8dUJLXxu+dsSsJkqTfniOFiwAHB
         63cB6LEjALSTVA8qEZXaRunQLoG69T7243XYIYMEVTqyjU2PBoBrg9P5BdrmcEyVx8y8
         LFnh4LU2RUKxgjQSzQPB/pU/zQ5QLhSLlcuzzSWxT/f4s9N+SuVfEzsB0A3DSVHWFejH
         0DpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEXHrPhdCkRC/wz7ZfgwMfQEWXC3DOK3hAt/GJNQILhueMIukAnRZ+BKU1HimA0ezlNnEGe/7Ka850T0M=@vger.kernel.org, AJvYcCW0N3gs6/wX0LFgN4CcmCO1Hslaz5ITFR/e1W+ipSvrgHnasLREbHcRYtA6cOXYus59PhEWc/51@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdh8EUS9tO5ZIhmvno6YQtV5dxuZcPeYgICT/9o5iVtgi1qKX
	AAMHaAiNRKOPb8HtqwisHpObuH1r4VCOnh0t8XpNExFeccQsPKJQde+Tp4bOb5UC
X-Gm-Gg: ASbGncvu0WLcTcUHLjznAzVnlAz5aXU8kdl0puAH8cUJby4IkzwnUy9VORFM8cKUjDE
	CIIY3d8vl8EkHum3i4WBrpIxuHWp5JGKzpvoRmLlXtIMRO6VmYU6wWQVAFg5RSuWSvCDI+Ie/cS
	qvQv4H3ItOtGe+cIP16cwqu8GZ8cS92j1vT4ifIDf/BLsq3m0RJzBSjimV+fecWQvZAbW9jSOEj
	Rb5/CrvyaZ9dEQGVYygdYfnO5YVew3cIDMhN+JdVFuFE5xMwBGfByfOfuU3ScS4bqKqyUVoHgTH
	rD7WWTmAvcUVR6JhZjpgT0Cb4LMegc3X4/Vakj2x5V19AhPO4TROlVi1eTHQWqNPDer0Z7dVzDz
	WrgPpFhLULXKTpkFirKEOrZUp0pW3eFaRyWjDhFBEwUcnR+fsrqA=
X-Google-Smtp-Source: AGHT+IGB8DmohHMW6msrYhaVF5l2NP3sJ9vRQEvj8ccMXD12u2Tcvi9xVFV6fZ6eicZPf1I2e8+k4g==
X-Received: by 2002:a5d:5d86:0:b0:3de:8806:ed17 with SMTP id ffacd0b85a97d-3de8806f363mr1024675f8f.25.1756891557690;
        Wed, 03 Sep 2025 02:25:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:599c:af76:2d34:5ced])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6db6sm335743485e9.2.2025.09.03.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:25:57 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jacob Keller
 <jacob.e.keller@intel.com>,  "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>,  David Ahern <dsahern@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] tools: ynl-gen: use macro for binary
 min-len check
In-Reply-To: <20250902154640.759815-3-ast@fiberby.net>
Date: Wed, 03 Sep 2025 09:52:11 +0100
Message-ID: <m21pon2a10.fsf@gmail.com>
References: <20250902154640.759815-1-ast@fiberby.net>
	<20250902154640.759815-3-ast@fiberby.net>
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

> This patch changes the generated min-len check for binary
> attributes to use the NLA_POLICY_MIN_LEN() macro, thereby the
> generated code supports strict policy validation.
>
> With this change TypeBinary will always generate a NLA_BINARY
> attribute policy.
>
> This doesn't change any currently generated code, as it isn't
> used in any specs currently used for generating code.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

