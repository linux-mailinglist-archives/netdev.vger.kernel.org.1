Return-Path: <netdev+bounces-160001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09316A17B10
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC01161BF7
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004B1E991C;
	Tue, 21 Jan 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+WB9Chv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5081E7C07
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454181; cv=none; b=JzXD+PvmgjsBhHJ6gVBlk6ztr0m9oBhNzdvTZVS7IYB/BJVYZpY1bo3mcE/Ja87Lu+5D9TI+plY9zI8/SzHJ4sCRvIDLV3FcXW4lr71xAA7KSoJhHmfwkz6lwlUTbtF1vjUm8HtBI92scz6xfHDF394ifYlV0cw4leW/jGqfpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454181; c=relaxed/simple;
	bh=JsAmvh5IZR6gXOlJbUqYkbDAThzeWUdtg+8hlx1xAB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EpuzMm/56O4UHcdfrhFqCuuM6gSQzMmQHsrDPNpVvIaNGsKeQe38mgir7sbUrnWxPsrn4zy6IDJw4vLivTBaPv77vRd1yfIstzthD5rUFWsxIqciNVXZV6wlO5znN/09GH4ezg5g7Sg1aDDUK4SJSHyZxn+eJQTiHSJhZLj96ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+WB9Chv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso101135355ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737454180; x=1738058980; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvU1rIPeOTZsNjVO7sqKwmrTv6yJOEyqSDtbMI+Suio=;
        b=J+WB9ChvWka/nBsUaEJSDx9f32HHxz4PcguX0dcqhNZSsjPk2Sp5kNoHtw9clLr1bW
         tGeVKKvzPYdlIDUtAZTRbDiGdx6RCLrzRy6iTzojew8lN0oC6Q/De6g6Nf6Vw1KW5gvt
         2XzgXap9B6BrWw/F0DSI8IYHTLbkf6xmitnUG4qmCwsp6lXPOScrxbXNdmcM4B2wM6uY
         HX47ko2rPYNwTikOiH5amV5AK/A6dP6D7K5ZIIZLTNH31osai88MVpNbzb9qW64Y1+OW
         iPyLaf1v1mnwZDt0xlTofmXXXM+H7pylFXHyTUf0AWRmGQ1aQkJ8Ife7wauElbfQKAtH
         pMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454180; x=1738058980;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvU1rIPeOTZsNjVO7sqKwmrTv6yJOEyqSDtbMI+Suio=;
        b=dNlztg9wEvF/amYGyUj0gwQng5nbDsseP2QrhO9m6r4INOrNfFGreFmmVGQYfdZIct
         cDDD95wOsQHLO+QbWdxu4VFirXNayYd+o9q6A9Eq4a8ogqWnPb7M3I1sRMYyjacEEmjK
         zkTRPuJYsJsd95UgQBDE1txyy6SuAAi80wjRQcQEsFT2KkpPbiy9NJr0bCA7H7qp7Nbq
         lVu1aFOO2INsP2r8gKiTGuHThjInGcMKM/ARXSzWxdNZuYGu/5+i7nsUUMLPtAJ0jDAC
         NoRE2rtNj89UJrHYRxR71g6kbcX7jiSNqmcgrKtTEVCruZk/kYk6HGIMErg+41sk9oiO
         ytWQ==
X-Gm-Message-State: AOJu0Yx9dtiGHqICJLyHYhfRtegToRHbnvxFKbo1un/3V0f8WKHia6ex
	MfewQjtgFzkxq9LUGTct2Ab9alsWdxn6PRJombOIDa/iXFelGMuv
X-Gm-Gg: ASbGncugyRFvbu0TaJsrTmRGqInWREWT43GBZ1FRER1Ps4G38+tp0HbDJlhZyuw2mvT
	53Azp0l1wn33/qv2EZmWGIiFP5GQp/AeKljU5K+NUtZQ4gBugTtz3hpEB7LsNy13ve33zcho7JZ
	d0D5N2/ZrIoxxVc8KUeDxtLtWJTww5OOM4CG3VvCD97l9TcxRmP9fkn7/BrqkKf0jFON7SaK1eI
	8yI3koh1uJFzStc2ZLE0InMgy8yfh4BjsT4wPQRh7pPAXf4XtjAf885V1kkHZDLv1/9pUteVow=
X-Google-Smtp-Source: AGHT+IFJ7jzS/+Nns56Tu4dVUmSf62rsvtPsIYZ84Hxwlna02Q2y/JgJOJDlaf8sCe7ldYcZndpP+w==
X-Received: by 2002:a17:902:ce01:b0:212:63c0:d9e7 with SMTP id d9443c01a7336-21c34cc00f8mr241164745ad.0.1737454179742;
        Tue, 21 Jan 2025 02:09:39 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba9afsm74414545ad.74.2025.01.21.02.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:09:39 -0800 (PST)
Date: Tue, 21 Jan 2025 10:09:35 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: [Question] Bonding: change bond dev_addr when fail_over_mac=2
Message-ID: <Z49yXz1dx2ZzqhC1@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jay,

Our QE reported that, when setup bonding with fail_over_mac=2. Then release
the first enslaved device. The bond and other slave's mac address with
conflicts with the release device. e.g.

# modprobe bonding mode=1 miimon=100 max_bonds=1 fail_over_mac=2
# ip link set bond0 up
# ifenslave bond0 eth0 eth1
# ifenslave -d bond0 eth0

Then we can see the bond0 and eth1 both still using eth0's address.

I saw in __bond_release_one() we have 

        if (!all && (!bond->params.fail_over_mac ||
                     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
                if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
                    bond_has_slaves(bond))
                        slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts\n",
                                   slave->perm_hwaddr);
        }

So why not just change the bond_dev->dev_addr to another slave's perm_hwaddr
instead of keep using the released one?

Thanks
Hangbin

