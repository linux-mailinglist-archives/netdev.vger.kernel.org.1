Return-Path: <netdev+bounces-141075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190DF9B9648
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D142D282B93
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F519F430;
	Fri,  1 Nov 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LktIwCgK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50631CA81;
	Fri,  1 Nov 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481076; cv=none; b=nmQ/QVTMmuSmBOsA6hr90SewZu5IL+0v/PzVmmmDE5Hd44i6ZWYPPvczMBQdT1puFq1/fDSVPop03LbIxlgNQuF8dYDfFnvSPvFphqRr46HNPDePlRCncZpXDlU5IAa4w4UFu+q1wIZ1V9Iqm268VdWGlIRG6WS4RMu1iSCzlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481076; c=relaxed/simple;
	bh=hrmMYL51uQ+aNmsN/cZfyxdeBlGg+T9v2778IgPjGn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU/e4YL95v+wW3KSSpqnQF9+k+JFRE4QGSQQcyg1w5IaCZgFAVEUOEpf0pTern77BnEkqA9BvUT9yGuKpe5GGYu9sD4aSySyPjFAbrb1sbJGE+T22zXxI/yhrQ/vFqddLXsOUA/Y9IE0UCEi/6WBNLlF4NokRvFbHw5RGwj7iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LktIwCgK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cec7cde922so443177a12.3;
        Fri, 01 Nov 2024 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730481073; x=1731085873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrmMYL51uQ+aNmsN/cZfyxdeBlGg+T9v2778IgPjGn8=;
        b=LktIwCgKzBarY8Ugz1EPYWV9v4ac7TZZTqaelSoQGRuCOpm15EtK6RL6Xj/T6SiQAp
         ljy8FuLWMIUYacV0OV2M3nYsGvA9s8l3Sf4tD16X+7pN3mTvO0u+i29zioKzU+GwUbLU
         DhobWACS9ghPGVi3MDChGYkdLxuCHlkZHzTnBRAwKWbYxhGybm4cOsx7M/YI4cnlvo8b
         uZNxpl14RMwAmlxo7y2CmgSmfqO0vhLATqjXyYZe3qtzK6mK6uJjvekhSCb5LkZTR9YD
         40nmfDkLI2d+UisWEc37une6RJnmCHgDIlnBlBz7UQ6xbB3T08BN5F+SkVU3cXWhHri8
         CAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481073; x=1731085873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrmMYL51uQ+aNmsN/cZfyxdeBlGg+T9v2778IgPjGn8=;
        b=WWzvBvmBoplLjB9vHNNrak0l1POhWs5czIIDyeRGHFtZRFIXWOtkTRDvuTBQ6HTgmo
         ciWgrvL+R/hhl45F9pS5nbTY/iz2Fg5rhnJksdOQTUIKVwlFGS0Wm/ytU0BLMlr7gDv0
         4gId3pCUZvFktPWyq+R1qMm1GrhLxlq7BPD9YnaouTSa/iNkAUWod7KbgyXQbS2ZshpM
         pIwT1PdKDy//bSu4FBa1bOgU2OpaJgadbCe4Xygz0noysOuUPMz5cMTZxka+jMvbE3uH
         d5Q9uSshgpp638J/wYlujVWAvSQbiN7kFhlo+MQoVyr8piZ4GIeOuLdB3vt0TRof86Mp
         z5pA==
X-Forwarded-Encrypted: i=1; AJvYcCWaxMd0RYU0IOQvC5qfQN/ewFXcxn29JN9TgfNJME0eZrRP8mMzc4BV8OR1M77tphtW5w17Gdgm@vger.kernel.org, AJvYcCXu4V+/N4KhgbPQhwVNsk7VGJIZxt6/WIunEw0h1yt+DNDzjKToYea8ytPh6VAUK/MQkqAKZ7CSEc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr91CLhsBJ7E3cKe04W5uku2TND9FecZJ5pAVO27wfOLDz8PFC
	Ave8jP1AXoUCr18eKFUGgPsX8SDWSsx5uzrxXVqzF7OE1lvVip0vaEIzfN1GRNC1Q/u7wwsCRqS
	lUzE8ugbhxh9WMSVpfAjbI65ovRk=
X-Google-Smtp-Source: AGHT+IEOYvjsewNxQ2cVWG6mSdsgcMhdy0Cf69WHKLUDeI2pXZkA5dAmk6XtbsPAup5IW3HXr4B0ph3rxctp4mgrEyQ=
X-Received: by 2002:a05:6402:518a:b0:5c9:76ca:705b with SMTP id
 4fb4d7f45d1cf-5cd54afde73mr8495018a12.34.1730481072531; Fri, 01 Nov 2024
 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-3-ap420073@gmail.com>
 <20241008111926.7056cc93@kernel.org> <CAMArcTU+r+Pj_y7rUvRwTrDWqg57xy4e-OacjWCfKRCUa8A-aw@mail.gmail.com>
 <20241009082837.2735cd97@kernel.org> <CAMArcTVXJhJopGTHc-DqK1ydCkaQj5-VRGoJ-saGNGeTLXZHcw@mail.gmail.com>
 <20241031165624.5a7f8618@kernel.org>
In-Reply-To: <20241031165624.5a7f8618@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 2 Nov 2024 02:11:00 +0900
Message-ID: <CAMArcTWQijQ5S44rJzrpNWrbgo6hyJiyUddcuA6ZoegZmkvTLg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/7] bnxt_en: add support for tcp-data-split
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 8:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 1 Nov 2024 02:34:59 +0900 Taehee Yoo wrote:
> > While I'm writing a patch I face an ambiguous problem here.
> > ethnl_set_ring() first calls .get_ringparam() to get current config.
> > Then it calls .set_ringparam() after it sets the current config + new
> > config to param structures.
> > The bnxt_set_ringparam() may receive ETHTOOL_TCP_DATA_SPLIT_ENABLED
> > because two cases.
> > 1. from user
> > 2. from bnxt_get_ringparam() because of UNKNWON.
> > The problem is that the bnxt_set_ringparam() can't distinguish them.
> > The problem scenario is here.
> > 1. tcp-data-split is UNKNOWN mode.
> > 2. HDS is automatically enabled because one of LRO or GRO is enabled.
> > 3. user changes ring parameter with following command
> > `ethtool -G eth0 rx 1024`
> > 4. ethnl_set_rings() calls .get_ringparam() to get current config.
> > 5. bnxt_get_ringparam() returns ENABLE of HDS because of UNKNWON mode.
> > 6. ethnl_set_rings() calls .set_ringparam() after setting param with
> > configs comes from .get_ringparam().
> > 7. bnxt_set_ringparam() is passed ETHTOOL_TCP_DATA_SPLIT_ENABLED but
> > the user didn't set it explicitly.
> > 8. bnxt_set_ringparam() eventually force enables tcp-data-split.
> >
> > I couldn't find a way to distinguish them so far.
> > I'm not sure if this is acceptable or not.
> > Maybe we need to modify a scenario?
>
> I thought we discussed this, but I may be misremembering.
> You may need to record in the core whether the setting came
> from the user or not (similarly to IFF_RXFH_CONFIGURED).
> User setting UNKNWON would mean "reset".
> Maybe I'm misunderstanding..

Thanks a lot for that!
I will try to add a new variable, that indicates tcp-data-split is set by
user. It would be the tcp_data_split_mod in the
kernel_ethtool_ringparam structure.

Thanks a lot!
Taehee Yoo

