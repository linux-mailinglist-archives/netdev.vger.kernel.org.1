Return-Path: <netdev+bounces-91890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300178B458C
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CBD282C44
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6707D481D0;
	Sat, 27 Apr 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="txVDaBo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE947F6A
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714213608; cv=none; b=cFbc0j7n8zAVNuupxzFDXYeSnLN1RLZKaaFJ56uhQVUuCg0GTT1Q8eAwE3IFw5AS7UGY37Mcb+Ej+HhSix2CGsDxLSJeHSbSfdMVTEukckWD5KYQZ9qbSkJtunSP71rl0Voq9dX46GtsVA1pOKRBaJwZKeoFVsvIoReO1wv8+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714213608; c=relaxed/simple;
	bh=Be+iXE5ZWZmZiYsf6YKgPKoetpxSLzEysnIFPjbbnsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooTQhkdnHGOQEaVnP7umypsvkZpVf0ED8AY7wvrz/2vvJIk3FKGmkHE/E04z6GRPHt6LCaIt3wLTUoN//398uqXGJDbJSVYeR3zbJjP+41sCNI91vnne4ZtpUHip5EkCWYVJ49r+8QYPdu8N1m+3iDSv8ZqEqWqHeGX06c5eolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=txVDaBo/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso14639615e9.3
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714213603; x=1714818403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TdXvI3rtPiyNsLQpke9JZNvQ5B9Rb4uX9WHGzp79Yc=;
        b=txVDaBo/DCq6jt/VeTHsvceaMxTEMoKM6uUGWuPJlFZ/5C1Q+MXVctO60LOq93FZuT
         1g3bMLDV4J5tEHn5g6Kpiw9BYfK5EkD5xAG4r1fzb62Xsx3LaBrYiLEKmxpz8bPQH15k
         YOMkTHIS5xP7S2NdBvGDpKkHsdEQYBkdrBY34mE2JTpCYcQW7R217zsTve6JC7NNrAJa
         iW4PX0OvlItdRUqZCJZtnREwbs9YTL67dZofTSpavwMIKusKXSF9pfh43f/uuSWKGH+s
         ixAhGAULaxAgsi8jkd6tznMJWEV0UoFNQdJ7j5tTOi6boFXzBPvK53CXoWQcx5gfEM5D
         zL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714213603; x=1714818403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TdXvI3rtPiyNsLQpke9JZNvQ5B9Rb4uX9WHGzp79Yc=;
        b=OCVKQjRZR8DcQd2Jx6icpXW4kNzha5LfJsDWoy2P9L/6+CyGTNnPv3pbZnMekfON8L
         R5cxJvJo8XcI3005IGpPnAXI9b8MgEs6xGcQ7LeUQ6KNCy4cJV7Q+QVjIpitDzmxLvQ8
         KABOD7Zo7TIEUfv2ViEdDGrCA9F00foQ3Wnr29fKSCW8nkjs3FNp+eN+jIZiIF0NuceL
         tkRLw7uYeme5vyof9wSKaxmudE7u7C2psmKX155IuxEVRGk1v96PgrLq7mLIfGgKhBGQ
         JHO/DrW+3OF9a2CkxLWX64B8Ywjo8EuA5eCGutsbzQiXLlztS4Uyo0qm6mZMVzr9MDsz
         rIeA==
X-Gm-Message-State: AOJu0YxOwMKUTigglD5J9aubNRgwSOwMIxBHmcrUr9dGMrfb70d5C8Nu
	fayNN7ZUPQzxXVll+/m5u18pXpfwYtnVLpF6KAxzBvoYHu7dcinlYu+sb9ziYnE=
X-Google-Smtp-Source: AGHT+IH1q3j8Iu+Vx4T4W/foDKCUCVaX7mzob9xy2IOz08E++agtVfBwuiB2esUXAVF9FB7tMKwg1w==
X-Received: by 2002:a05:600c:1e8a:b0:41b:3c4c:211b with SMTP id be10-20020a05600c1e8a00b0041b3c4c211bmr3885472wmb.22.1714213602746;
        Sat, 27 Apr 2024 03:26:42 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id p3-20020a056000018300b0034c91903c2bsm1729780wrx.48.2024.04.27.03.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:26:42 -0700 (PDT)
Date: Sat, 27 Apr 2024 12:26:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Shane Miller <gshanemiller6@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: SR-IOV + switchdev + vlan + Mellanox: Cannot ping
Message-ID: <ZizS4MlZcIE0KoHq@nanopsycho>
References: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>

Fri, Apr 26, 2024 at 10:35:28PM CEST, gshanemiller6@gmail.com wrote:
>Problem:
>-----------------------------------------------------------------
>root@machA $ ping 10.xx.xx.194
>PING 10.xx.xx.194 (10.xx.xx.194) 56(84) bytes of data
>From 10.xx.xx.191 icmp seq=10 Destination Host Unreachable
>Proximate Cause:
>-----------------------------------------------------------------
>This seems to be a side effect of "switchdev" mode. When the identical
>configuration is set up EXCEPT that the SR-IOV virtualized NIC is left
>"legacy", ping (and ncat) works just fine.
>
>As far as I can tell I need a bridge or bridge commands, but I have no
>idea where to start. This environment will not allow me to add modify
>commands when enabling switchdev mode. devlink seems to accept
>"switchdev" alone without modifiers.

You have to configure forwarding between appropriate representors. Use
ovs (probably easiest) or tc.

>
>Note: putting a NIC into switchdev mode makes the virtual functions
>show as "link-state disable" which is confusing. (See below.) Contrary
>to what it seems to suggest, the virtual NICs are up and running
>
>Running "arp -e" on machine A shows machine B's ieth3v0 MAC address as
>incomplete suggesting switchdev+ARP is broken.
>
>Problem Environment:
>-----------------------------------------------------------------
>OS: RHEL 8.6 4.18.0-372.46.1.el8 x64
>NICs: Mellanox ConnectX-6
>
>Machine A Links:
>70 tst@ieth3: <...LOWER_UP...> mtu 1500
>   link/ether xx.xx.xx.xx.xx.xx
>   vlan protocol 802.1Q id 133 <REORDER_HDR>
>   Inet 10.xx.xx.191
>
>Machine B Links With ieth3 in SR-IOV mode in switchdev mode:
># Physical Function and its virtual functions:
>                                                 2: ieth3:
><...PROMISC,UP,LOWER_UP> mtu 1500
>    link/ether xx.xx.xx.xx.xx.f6 portname p0 switchid xxxxe988
>    vf 0 link/ether xx.xx.xx.xx.xx.00 vlan 133 spoof off, link-state
>disable, trust off
>    . . .
># Port representers
>893: ieth3r0: <...UP,LOWER_UP> mtu 1500
>link/ether xx.xx.xx.xx.xx.e1 portname pf0vf0 switchid xxxxe988
>. . .
># Virtual Links
>897: ieth3v0: <...UP,LOWER_UP> mtu 1500
>  link/ether xx.xx.xx.xx.xx.00 promiscuity 0
>  inet 10.xx.xx.194/24 scope global ieth3v0
>  . . .
>
>SR-IOV Setup Summary
>-----------------------------------------------------------------
>This is done right since, in legacy mode, ping/ncat works fine:
>
>1. Enable IOMMU, Vtx in BIOS
>2. Boot Linux with iommu=on on command line
>3. Install Mellanox OFED
>4. Enable SR-IOV for max 8 devices in Mellanox firmware
>(reboot)
>5. Create 4 virtual NICs w/ SR-IOV
>6. Configure 4 virtual NICs mac, trust off, spoofchk off, state auto
>7. Unbind virtual NICs
>8. Put ieth3 into switchdev mode
>9. Rebind virtual NICs
>10. Bring all links up
>11. Assign IPV4 addresses to virtual links
>

