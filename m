Return-Path: <netdev+bounces-80237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6FF87DC48
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 03:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305532821FA
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94E4405;
	Sun, 17 Mar 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcGNMek+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2731256A
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710644244; cv=none; b=LzFbY6V2WXmXrad4aJHJNasavXuaNpXWGw9Te8V8xGHeouVAk19r4vFsn8Ix3WZFIL3U3dLCmcQNHnAfVw95FdQ0GF4Yc1g4v7CeJcrBSg8UTYOWFYltjU4MqXuKyVF/ASmpL2snpvJfD75oZf90b26CKKA89h8nqQYrxCTwrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710644244; c=relaxed/simple;
	bh=4i2bzRTnCI4ul/294/ThdOf5odeiddKwKaiM+gf3ckI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j1/5S75tJ3VwQDO8f7szFcrxt7Y9eqfb7dakY80t6CUNv9XPOemXHOYuKfqNKYB62Kr/AmU/pF7+J4+Bu1he4Jwl+MiVp9dFI/u5rhh09V8YOcpq8l+WXxNu51tT/ZetSkChcQ0JwERd8iFa4aELq7C9AbtFU/5w20TnDCzQE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcGNMek+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789e209544eso138151885a.0
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710644241; x=1711249041; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HANKoKsmElOZ2FPhSm7StpjqP3x+HPdeCGStB93Z5qU=;
        b=RcGNMek+rdNdxcZi8nxnfGaYRVeNbUS/wvKodXqpx3CyxQ+b9r6IKLpVtoZGFxhV50
         oW3eaC18IWjbOp9uZICcRUZKuwytZwn42g2mxnswSPxlrQmrpdjFU6JTVqjGcplnXwSK
         yDQPdYmLZcz4c77Uw4byujFWxhnxp2pLXnDocU+Tv8BcqD0bVRMLlAiwiul9FrMFHobi
         O9OX/MgtoNDM7/0zAx5crmWeiDSC27pXmddnjMkR0pbxjxFKxtsVnmRog31hjz1D1rnk
         22u9pkwnkmvDn7vwH54eQc2jCi1ndOfEEdEHCA60YmwtBzTrohn0U8CIDT07FlHPC5TE
         iHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710644241; x=1711249041;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HANKoKsmElOZ2FPhSm7StpjqP3x+HPdeCGStB93Z5qU=;
        b=gdb6QScppqKCJ2KX5tedlDdnfON3CilpEybg+G6arvo7EYDF+fkfqdQ+Z5r8iwsDib
         cs480gWLPYZ68j244iTraaOnXgU1AvQD7dLb+bxKsfjImLLQYmn6dWfaNbHuFLYRvdIL
         UMo1KHBrC1lDvDn53YyB839NBAX62e6JgWgha3s9pSIEiLBDZIep+C4A25BO80GNyZZt
         pmIRRx6+wEMoItajnobU1d4LLugE5DbiuV9kDRZECFww5TwEYqfsY/3W9GAHPQ5t8POJ
         QZoIrISijg+olLWZBHWrSeInARXExDrnVQc4g4Y3cundlRNWMJtvorVU4PadvrPXY3a2
         uO2g==
X-Forwarded-Encrypted: i=1; AJvYcCVe1PXF2LqTpA0h2nD4MkYVhsAOJ6uBBrKF1lGTmmkt6f+5Qmp3RmZecUveR6MyxeheRq9p/48b2Hb5zFpzUs2WN7NEYAf8
X-Gm-Message-State: AOJu0Yy/HtcY4ghI3qCNtVtfsUcc7aJO/KMAIGZsWmEDhz16B+/CGlSi
	l+JXVd47in62vr6YShhzB3z7FG2krNvHeugG7Gi4Cp1f549bRlk=
X-Google-Smtp-Source: AGHT+IHa980Lyr+eCpB/9FbsOXsi4OxllR+947dExMVhFg3CnNKvwMZKRqKv2Cp5dW2y+r/I2nIo1A==
X-Received: by 2002:a05:622a:87:b0:430:c601:5a33 with SMTP id o7-20020a05622a008700b00430c6015a33mr2119014qtw.46.1710644241452;
        Sat, 16 Mar 2024 19:57:21 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:b422:c93e:ec7a:e201])
        by smtp.gmail.com with ESMTPSA id fh3-20020a05622a588300b00430baed846asm1312005qtb.62.2024.03.16.19.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 19:57:20 -0700 (PDT)
Date: Sat, 16 Mar 2024 21:57:19 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, zzjas98@gmail.com
Subject: [net/devlink] Question about possible CMD misuse in
 devlink_nl_port_new_doit()
Message-ID: <ZfZcDxGV3tSy4qsV@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Devlink Developers,

We are curious whether the function `devlink_nl_port_new_doit()` might have a incorrect command value `DEVLINK_CMD_NEW`, which should be `DEVLINK_CMD_PORT_NEW`.

The function is https://elixir.bootlin.com/linux/v6.8/source/net/devlink/port.c#L844
and the relevant code is
```
int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
{
	...
	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
				   info->snd_portid, info->snd_seq, 0, NULL);
	if (WARN_ON_ONCE(err))
		goto err_out_msg_free;
	...
}
```

In `devlink_nl_port_fill`, all other places use `DEVLINK_CMD_PORT_NEW` as the command value. However, in `devlink_nl_port_new_doit`, it uses `DEVLINK_CMD_NEW`. This might be a misuse, also according to https://lore.kernel.org/netdev/20240216113147.50797-1-jiri@resnulli.us/T/.

Based on our understanding, a possible fix would be
```
-  err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
+  err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_PORT_NEW,
```

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Chenyuan

