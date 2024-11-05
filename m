Return-Path: <netdev+bounces-141936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D4E9BCB6F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C352F1F21775
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB76A1D278B;
	Tue,  5 Nov 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLV3piGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18716D30B
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805405; cv=none; b=lZVseWJJ3nOpS3LrnGr9bQF5qk33+AVQzJF3EFf1ui+sOs7a6GKlJUuLS0MWs/vW02iINMDOq3rl+uGPLgosYCgZIdVGe9RPkUcaRPzy3wNd5/hcnrlyDevbvfB/COjWNeGkImGSUE6dhualxYj+rwITWexhWatPL279Ovy5Sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805405; c=relaxed/simple;
	bh=ercNxfvIrrmzNcNJCiDXtUSiO9lAFpCrkRRf543MveA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M8YbrQeTOO+vOoG/hCRk3UE167+aHakfBLYdF0FI6GbpmX5fsx08Jt0yjuRQ1GmFARUi23y2T69V1LTmvCCjrp8buFgKytFVoBptu2gM9eumMllZ4WVtTVvZRDa/UKs8GiC+WxcGcgz0MbbXzNzK2drQqft2fTm/yAojYpuJdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLV3piGj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720be27db74so3545019b3a.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805403; x=1731410203; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fjqAakzufIKFV0XekIaHdRyf9sQ1VsNPAuLRB07k9M=;
        b=LLV3piGjdatM1krPP8wxD6Ngs0ZQ6iRdcGmg+ADXa8PlcXBgzSKyKJvh/K55cWvjH+
         CPjOpzap1uOZkFM7WS0WO5Bo6Me2hIYzWFTXEnXzaU/7SOafn5CJQqrjfoZvf9ZIpl9U
         wKH7N8hDWqFLX/jSW14nVvoKfnN0irPSWEX3HHWA/OluyffXW/5yFTtJ9TcpHii+Ng1J
         pD/bTlXSQMYrcbEzKF1+tCNL0UIhmkcAfN06aal/X+73CFga45bySi9144qVLzxKAh1Y
         SlkljmpbtD+4LfuaXfKnAyY8gH8JYZIpD1emWv7uvwCAIrspI45FmmVvZd0fTL5XkDPa
         1emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805403; x=1731410203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fjqAakzufIKFV0XekIaHdRyf9sQ1VsNPAuLRB07k9M=;
        b=oNuqK+rYPQHehzWUFz2q21+hJQvAzUO0C4ayUJ95iMX0S0hH0Ndpt1V2Hi6MmbBC/t
         FaMqVrIeiG+pQXtyWCPtZXjcnerv2VTAIgfrMP7SO8w+gWlorDyGGD8WNgLMX+j5Izvk
         3qbW5HL9Yzb8bDIdWnyyCm7s0gWe4V8pPc2F7HdltLHL9cOrZWCnNebmx+m756ZfRqH7
         pZ4NzaDAfKm2IQsMWrEJh1squCflHqqenwBZn+W3ac7R8WZvbw3fK/osdFNfICz9/SzQ
         XNVaD7u8+Z4KQaZKgXmmYJpR1Gz49ydSJaJCcIP0FQ5gvmy1h+LLepPlyy3+I1l5Z4RU
         O77A==
X-Gm-Message-State: AOJu0YzP+QJ25/uFIXqKKhZ99epJrvBw0WQUc3eosGDU9exyHhQVsor3
	WGSJoLBeM4PKXVQsSqyQ1S95Ol8PyjE98w6F4xjieNaFIz2CO3gpvQqlkXi96iY=
X-Google-Smtp-Source: AGHT+IGSLNCFwXHNs0laHi/DUrirRyuMc68q0W4CLebKk58NZs1s/0Y5GCIjBARgEUcKUhqGI3Zdog==
X-Received: by 2002:a05:6a20:49a7:b0:1d9:3acf:8bdd with SMTP id adf61e73a8af0-1db950872b0mr23477937637.22.1730805403254;
        Tue, 05 Nov 2024 03:16:43 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f922dsm8707938a12.68.2024.11.05.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:16:42 -0800 (PST)
Date: Tue, 5 Nov 2024 11:16:37 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [IPv6 Question] Should we remove or keep the temporary address if
 global address removed?
Message-ID: <Zyn-lUmMbLYO64E_@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sam,

Our QE just find the latest upstream kernel behavior changed for temporary
address. i.e. In the previous time, the kernel will also remove the temporary
address if the related global address deleted. But now the kernel will keep
the temporary there. e.g.
```
# sysctl -w net.ipv6.conf.enp59s0f0np0.use_tempaddr=1
# ip add add 2003::4/64 dev enp59s0f0np0 mngtmpaddr
# ip add show enp59s0f0np0
6: enp59s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b8:59:9f:06:56:6c brd ff:ff:ff:ff:ff:ff
    inet6 2003::d280:ee50:d13e:a1b1/64 scope global temporary dynamic
       valid_lft 604793sec preferred_lft 86393sec
    inet6 2003::4/64 scope global mngtmpaddr
       valid_lft forever preferred_lft forever
# ip add del 2003::4/64 dev  enp59s0f0np0 mngtmpaddr
# ip add show enp59s0f0np0
6: enp59s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b8:59:9f:06:56:6c brd ff:ff:ff:ff:ff:ff
    inet6 2003::d7c7:a239:2519:2491/64 scope global temporary dynamic
       valid_lft 604782sec preferred_lft 86382sec
```
    ^^ previously this temporary address will also be removed.

After checking the code, it looks commit 778964f2fdf0 ("ipv6/addrconf: fix
timing bug in tempaddr regen") changes the behavior. I can't find what we should
do when delete the related global address from RFC8981. So I'm not sure
which way we should do. Keep or delete the temporary address.

Do you have any idea?

Thanks
Hangbin

