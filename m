Return-Path: <netdev+bounces-183214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F372AA8B69A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6927A3AB4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AC2472A8;
	Wed, 16 Apr 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGj4+/98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573423BD0B
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798689; cv=none; b=afAcaENUUAj1JagF9irHaGLnrFSUGVR20RSDjaTrRk+6JhRphMzmZOR+VL/BzoGeEpB8k7ERDUkHOJPZ9KN5PWjaM0JHWYtyeFYK6dL4onZNJMGBJDXuQN2TiRpxEUoRCSKu8DLAjBHRDy5CjSahsl970NK/1McaOjiRX/wsUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798689; c=relaxed/simple;
	bh=lKwGTrGnL73k4+AUdIs98CJ3weTFUSNv9T+NqjGq8rA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rrL+eoFfxaANho29mCwgbKPrP3s+k8R1kWagPlcZJr72DBLWDmuVWAKRk0d/hiaTCFEg6My05G5tSO8Vk6nBBuz4ELdsHgQvBPaQ+VYNhoQS8oGuaUFNTd6/WhzvKpwSWkZ3WvdNHbY93x0Qfn/otiIPVplrs3vS/sq1IGB3XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGj4+/98; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913b539aabso3988770f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798686; x=1745403486; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKwGTrGnL73k4+AUdIs98CJ3weTFUSNv9T+NqjGq8rA=;
        b=OGj4+/98lIxIlimVcRyEo8zl835lRk7kK3K8SJCYjH2TLZcIK8SAHNKUJ2EYK8ZU58
         /bNOnmDIJVXhTeXnhtZP82n4vDO97CsrcYSDFnKMGvuzZvsUj2VZSBB0kZos1jkJKOYM
         P+/X3X5C2HEYn8VAuU0CA0rT/aZIufYP3d+u+O/JSSLOY+h0B0T4KDz/inclwCerA8bE
         H0MozneLvCqLwpkRe0nWWt7dNY91l8MNFkgtYy1Yu9YuZYnWiMMNiDujV/dB4CtfC6og
         OLCD7j6fyPUldKFCgJfGm3tZSNW+sBwRNO2bgC2P4qYE+jFJldikMSCjeEngEcFqTTsY
         VJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798686; x=1745403486;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKwGTrGnL73k4+AUdIs98CJ3weTFUSNv9T+NqjGq8rA=;
        b=Yqqg/EmA5zEgwppIJs9duBbJyk+9Totuxri0NczPzFlZBqrZQtTmpiFihplYAcYjLG
         j3T9nuIPPo++XuJ+RQGVBM/6yrdhN3L3PWpElnyPLePnWHkC9iemNQrzmp8fY3A9Yib+
         zUPMXZ4XLrOfki/s/1mP+6G14ewZOJz5xUSsHOm1RYaUGcFHn7WvFuwWD2Ic/0t1EDLX
         vHqxIdd/HP7PsE92PoAHHCj7WB42EvVPpfATA/t8xOsWSpdSXWZ9e/qu/0IKGQHcY9Oj
         nDvYDARswPymv3fs/SqWUZiQXcF9OBjTlm+7Vn9YvHjdJZ/SYn//ooLDseacgyN4BNgE
         Qk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw330PYsDVl0z8QAFzMv5eX6D5eLqQxt2ZuswmFf5fX+BaMy5zevriLjC2Bg1xHyWCHEABOIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ofRujjITrljY+6Bduy68lqwJ0+DmfTnJJV+1gvBGvA5V54gV
	EILSV1vZT8gnj540qDqMRduk+Q1LenWrewu+XIdShd+x4zbnW06y
X-Gm-Gg: ASbGnctaeWngeAEVFDMVvp0q19rO79V5ymeYyD8Gsw0mVtUXpP7ZWSwKV53K069Hkx1
	EK68eUzeAN2XlR4uX2iVOdad+D37sFskchyGyBbofx0L/u7Py++Z2XGVaL3KGF+pxM0wnDxkhaP
	36FBoJm9WJkibRMGdlJxxI8+EcbJkzcQR8HWDWKlpxD6C8tLLIuaGP4mtKInXnFe9kwHdRW3Lea
	/M++pQ3uBPGG5D7q8i1S7Q5Mgn9OkreE+2VQJNNMXSVQNEl3WYDEURy0yRWSaBRfn8uU0g4+xhv
	2rXq9nA9248epfmzJlpMnewsGBCkFpl/uGdIMdhqDVMWObKlq0FAzT7OAA==
X-Google-Smtp-Source: AGHT+IFxNCXEdXy6TeWX7NdE6djPhEW6zL3zDmuUmTnWwrnNGIP5kQKicjKfguNS02NP+xkdVml1ew==
X-Received: by 2002:a5d:598e:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39ee5b17cdbmr1182177f8f.20.1744798686541;
        Wed, 16 Apr 2025 03:18:06 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b54579fsm16877225e9.40.2025.04.16.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 5/8] netlink: specs: rt-link: add an attr layer
 around alt-ifname
In-Reply-To: <20250414211851.602096-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:48 -0700")
Date: Wed, 16 Apr 2025 11:08:54 +0100
Message-ID: <m2plhcl8p5.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> alt-ifname attr is directly placed in requests (as an alternative
> to ifname) but in responses its wrapped up in IFLA_PROP_LIST
> and only there is may be multi-attr. See rtnl_fill_prop_list().
>
> Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

