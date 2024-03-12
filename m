Return-Path: <netdev+bounces-79415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E68791AF
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A39281BB8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7F78297;
	Tue, 12 Mar 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty46pv05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4A3D3A7
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238119; cv=none; b=EmkzgNciNcyNptR69q5e06UPFlRINug3ZK63mGNfc8G6vUamhveinSEtQ/sBcEeqvxkG5LiWRY34/CnpBlPUOwGPa/ktJVQHtwJWipeyByHWRQs0k4BaZF/SEtyiyXRCiRYJmSjcx6O3dAiMgiOyx4CPVcp6/P+xPSYBPxcaBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238119; c=relaxed/simple;
	bh=sb3xs72tNNne3/nKiRTK9VNgkjWof4CY904qHU+lT3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NUrpEdPxtRK4He/HqoSkmBpo5ZgD4ymYdjYLop6mmuDtmZsTB2Od71tCzmy0DjX6WKcPPcdZuKq2b9qicmJ8fiMxhcJZZtibdjp7qEEFjaG6jc9EqEFykRoAIdqchCBlo8X7g3eR3XxXALaDbOpO3uIXirhTub/rf87SMr+yOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty46pv05; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e64a9df6c3so4348189b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710238117; x=1710842917; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaM1gExR2zQwsiRWtDnOLwnNUwBMIE8H218yp1tumLQ=;
        b=Ty46pv05PNFkyiOPTIDOOVXSdeXooJcZvycDJpLhDDdXbDkZLWc6oFG1N8ISoqiYWj
         F61j0FWQHc53FNoVdzOXXyoPLpSDozS4/Wg6zESNGCPgy2edc1QhFStJiUl+uCzIWeAq
         vacyeUaQPUVBFLm/sS8BcEybI1PVLuGImlvR2cGsffR9oh3KrmrkJ3zhLRWRe7nsiLZO
         KSBCzEnmjnxx8baiBn0S5eOcjFMpzT3ONJUZJtMUFIipOXBSz9BxMpHYz5MF4InqRJOq
         4xUdJutr0qe+bjRNJ9pIVmxajkX/YsGqFKwlq4fu7kGTJC2jf1FzMNWiThYbac0QcmiP
         f88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710238117; x=1710842917;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaM1gExR2zQwsiRWtDnOLwnNUwBMIE8H218yp1tumLQ=;
        b=t4T+gIayDcnqNUODvLCLW3BefTnaASqgmVcowl4tBnQRENzdjh+1esCmfCZ6vWduyY
         ZLcI4OdddXUjrKeqLIaMol8JhAKnkauHE32z1CgfMqqoT4BHcQY/PneRim8dwc/uBeC9
         EqB9q8slOJqzhUjKMc/HlSclvFttNO6385R8cfoND/W+m3B1tvuBrebIqq6Pe48J/lJd
         s3CsyVezoFjQgHMlm3K8VxHCoHhIOlH9lQJumlkFRdH70QwpUaXrJb6BmAoRGM6hBEuC
         jaliw8K8k9QpeDRW8eIKBrBem7DL0PMft0x4WJgI+TlRc56XnZZaDgZSIt2pnsvVlJWw
         hdKg==
X-Forwarded-Encrypted: i=1; AJvYcCXhiSafc39bvOeJ0AZu8OlcRDjOvXkDEEp1cWQvM0Q4v3F4gvnoVkaG8Z1yhrQCOX05Ht6k5a7dlmWtovytozdQMLxMdjaz
X-Gm-Message-State: AOJu0YyOnv3rlk1nQjlc1Rb6NLuTDeV8Cm+NtmL9ndJGSWfkLJfaPurB
	jtwfse1oR+/yRSBkE92YxYkKGVyhRT0GC6D5r4jagrSfUJENiqd9gmxutd6+fUwr+w==
X-Google-Smtp-Source: AGHT+IGKvdVjm8ERFGYJ92iL/7rlLGqMGC2a9I1W+VjeqAL0Y4hXPE7GUF7t3J4ucQPvCMSWfslt+Q==
X-Received: by 2002:a05:6a20:b2a5:b0:1a1:818a:1002 with SMTP id ei37-20020a056a20b2a500b001a1818a1002mr7397560pzb.40.1710238117481;
        Tue, 12 Mar 2024 03:08:37 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001dd88cf204dsm5163700plg.80.2024.03.12.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:08:36 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:08:33 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: How to display IPv4 array?
Message-ID: <ZfApoTpVaiaoH1F0@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jakub,

I plan to add bond support for Documentation/netlink/specs/rt_link.yaml. While
dealing with the attrs. I got a problem about how to show the bonding arp/ns
targets. Because the arp/ns targets are filled as an array[1]. I tried
something like:

  -
    name: linkinfo-bond-attrs
    name-prefix: ifla-bond-
    attributes:
      -
        name: arp-ip-target
        type: nest
        nested-attributes: ipv4-addr
  -
    name: ipv4-addr
    attributes:
      -
        name: addr
        type: binary
        display-hint: ipv4

But this failed with error: Exception: Space 'ipv4-addr' has no attribute with value '0'
Do you have any suggestion?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/bonding/bond_netlink.c#n670

Thanks
Hangbin

