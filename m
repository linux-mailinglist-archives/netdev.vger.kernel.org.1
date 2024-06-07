Return-Path: <netdev+bounces-101773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA255900059
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6849628DD00
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0C15AADA;
	Fri,  7 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2rYfswI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18261CA85;
	Fri,  7 Jun 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755010; cv=none; b=HauA/V73deMbyYH5TB+lq5KDQBc1DW21qslmKHA//Npk6rVo1prFLqx0Vk/jQ0bqmtY+/7FudhvgWjVMF9IKR34rZpsiOW/fBqleDuDhZDpabNyalSJ8X7rniG1BZbYD7SOcwrnt/rG0QtxFzOFqAoQ8VFBc5YUmkxxO2JYop10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755010; c=relaxed/simple;
	bh=aE4eaP6bHfiBKjViBn6+Ujbx5P3RY+W8dBRi8lIgZgQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WBIERcymfeREB3K9q6Gv56sixA7Q/H+GciY/FxijneN0icYK1LcLIB62uCOBEYaL6rZT6Dxbi2ENLw0iQcS4YWcN7/c6IR2GdEYSmrDL0KCf2XaKI19mMm9Ofc16qLGydj8aaQ+L5Dr52J6iDmUO7A7GNSUBDghhEopBNJcyGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2rYfswI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so1636283f8f.2;
        Fri, 07 Jun 2024 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755007; x=1718359807; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9doJyVU9qxOkAk1maiwctIn/+b2qh/iJuF285ssJygs=;
        b=i2rYfswIaP4UR7EOonuz5WE0BfuFLaT/+6HfXO1i5tU0Ss7YB+g3L54syjydQQSWIy
         VTspKpdBrArmpNimjGZir45Nqv/9+ylcbSFaJXpHJZK8mb6U3BeCtCp8MJB9ma/lUXCu
         UXsRPx7LIlPsCjKCQjPQTrMZmE3jwjFhq3pqBl3acxEe6esS69XnttDAC7ufz9xE6qIt
         /GJWR6R/I8AgIk4130eRAxMZJr8uyQaDxy+nTqO+2gMQTiyvpP40N91pVeadKifm0kbQ
         bJoypROFLt3XaM65mGgayaPGCU647G2/Bp0Iudyt9u1KLBzxxMYB+LRgv4z/UI33sOfp
         +PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755007; x=1718359807;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9doJyVU9qxOkAk1maiwctIn/+b2qh/iJuF285ssJygs=;
        b=W6pJdKxgh56j0NVvZPQrsx0zJRE1DlpDWXCaCdFzOyG1d5NxPI/zk3UmRGVr37j2Wc
         rqz4qh2o596tv5RrmoKBTP06j9ysvIM4VnhemrxjAHa1dn/MkgRuT3Mhsn0fH3Pw3pqM
         JfxZEYb7HNepQ4lzPLPLAqsI+VLbdq2m97XMDRPw4vcfuk/zy+n+r+JyVzeuwIFu9OZN
         Z3Zq/dz7nEqHhMTTruTLJvQDi3fAEBJyN34+RyoZHUmLAMGGv5iPTjdL3rqLLUy6am/a
         a/AXl8Ygm7YbohU+wNX2gkzbGajb8ExYmMFWw8EwonRiWFXQypWPLJ4mYS6VWRT5pXAI
         5G0g==
X-Forwarded-Encrypted: i=1; AJvYcCXae4FOVdo8eAgixQFg5sFDHuAfcNTHiKGRlZ0/68z9YDQHMKmKW+Q0bkMJnBQz8ls4HdTSJm5ZJD9pMvhjgDwNE26IbSENwRwu43iEZo0R6QP0bDgbum2nI0gGbSVS5S45bMhA
X-Gm-Message-State: AOJu0Yzl6zLAA9el8ElPeAOrh1HUKQiTYbUGrnSMMs/2bHQBlQWwFlpH
	AKGx8Sn52IAGG3fzTCKFi5J/vtXQ8Oa7ZdOnzVOvp1XOve7+740C
X-Google-Smtp-Source: AGHT+IHeuwI8aQpPF7FlWiipVfMQ+aCBdx+r827kcPTGG9R8HQodAdhRd5gkN78Go8ItaGb4vow3+A==
X-Received: by 2002:adf:f00e:0:b0:35e:7dfc:345b with SMTP id ffacd0b85a97d-35efed65631mr1561970f8f.35.1717755007023;
        Fri, 07 Jun 2024 03:10:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:4d:91d6:b27d:6a1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e989c9sm3658427f8f.73.2024.06.07.03.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:10:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Oleksij Rempel <o.rempel@pengutronix.de>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Dent Project <dentproject@linuxfoundation.org>,
  kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 3/8] netlink: specs: Expand the PSE netlink
 command with C33 new features
In-Reply-To: <20240607-feature_poe_power_cap-v2-3-c03c2deb83ab@bootlin.com>
	(Kory Maincent's message of "Fri, 07 Jun 2024 09:30:20 +0200")
Date: Fri, 07 Jun 2024 11:09:38 +0100
Message-ID: <m2bk4dm5ct.fsf@gmail.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
	<20240607-feature_poe_power_cap-v2-3-c03c2deb83ab@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
>
> Expand the c33 PSE attributes with PSE class, extended state information
> and power consumption.
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
> 	     --json '{"header":{"dev-name":"eth0"}}'
> {'c33-pse-actual-pw': 1700,
>  'c33-pse-admin-state': 3,
>  'c33-pse-pw-class': 4,
>  'c33-pse-pw-d-status': 4,
>  'header': {'dev-index': 4, 'dev-name': 'eth0'}}
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
> 	     --json '{"header":{"dev-name":"eth0"}}'
> {'c33-pse-admin-state': 3,
>  'c33-pse-ext-state': 5,
>  'c33-pse-ext-substate': 5,
>  'c33-pse-pw-d-status': 2,
>  'header': {'dev-index': 4, 'dev-name': 'eth0'}}
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 00dc61358be8..8aa064f2f466 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -922,6 +922,22 @@ attribute-sets:
>          name: c33-pse-pw-d-status
>          type: u32
>          name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-pw-class
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-actual-pw
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-ext-state
> +        type: u8
> +        name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-ext-substate
> +        type: u8
> +        name-prefix: ethtool-a-

I see this is consistent with existing pse attributes in the spec, but
are there enumerations for the state and status attributes that could be
added to the spec?

>    -
>      name: rss
>      attributes:
> @@ -1611,6 +1627,10 @@ operations:
>              - c33-pse-admin-state
>              - c33-pse-admin-control
>              - c33-pse-pw-d-status
> +            - c33-pse-pw-class
> +            - c33-pse-actual-pw
> +            - c33-pse-ext-state
> +            - c33-pse-ext-substate
>        dump: *pse-get-op
>      -
>        name: pse-set

