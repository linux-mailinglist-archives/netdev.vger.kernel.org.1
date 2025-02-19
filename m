Return-Path: <netdev+bounces-167666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14999A3BAA9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D827A6DB6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE61C3BE9;
	Wed, 19 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyjCBS9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACC1C1F0D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958226; cv=none; b=Ux8qPDhyspmEXibzdXW5nrX64SLqN7QZwm510o+/MFurPGeAbFkxCHgIQ8VP3F9vwOFXKqF24RoPS7UUhX+0BoWY33NG16jPr4MMJ4MZpOWMK8ALyZYH6jA0Ry57DU3naMArEWVbecf3N2Pf3R/wI9XqiGdQ5dX6OPW7EzMD0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958226; c=relaxed/simple;
	bh=uIFSCLz4+V8jRDeTikhOTLIbvtLnwn2fGctIPUMBSYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s+JTyyENMHavv+Bk0NHt76GrtMZb3NwTXQ0lfvhvKwOTKaEkNGrvjeolWly/Q2JFm++xdPMbz3NtB2bUp5ky0fn1X+nKZPptgbtyLMUddKsmLs44RnBwRDHPzHJsPmORjxH2KRPLHjl5vqXAlA4p/Xe8hJKkns6Fyjtigrn77gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyjCBS9C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212a930001so81233025ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739958223; x=1740563023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS3WhWqkq6keTVtDDyE0AF50Cw5cJCMTV8o3PIvSq3E=;
        b=YyjCBS9Cetk/uGl6lieP+3X/Cn707jhXX+ANA7sv39z1YClwAdyfVbjM1nqswXWyEC
         lU8dblW74MIREaMLdKHxNHdaupvN59yXBe4+h6MYqScjzh5pCid6mSkTejHTv92IabVf
         aGYz6f4QN47sSQ3CFuZSTp9T6aRmXNq6AtQPACEj+NEzknVLQYe2BkpsB/I1g+xRihF/
         /l2inT9itGkcsMY9vbJ0o50QL6fMiF6J/PDWJfgSnqkG0MfxhrtzW9pzQRqy8YiTs0J3
         EMxQPlIamqbrCHSvpUVLi0h8Vx1NwVzuws+e3s18zQF8hWKYD6bMrtvlohHy0P2VxQ6K
         a8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739958223; x=1740563023;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS3WhWqkq6keTVtDDyE0AF50Cw5cJCMTV8o3PIvSq3E=;
        b=DAUXtjjnOksQvTm48olNUY2zR4gCUwMw7dV8JEG2Hzif1taRJs3IYE5OMU9ubJWwOG
         9nnETtQDwN+taZmvNqGePgF0d5q2/UnPb2l/hUqa8SXCLs4/+SdYjWweO0hMas7QmVyi
         d2CDP9y1fr7WHrImR/PvX/IrhmJ6T80DQLt7Ul6ez6lGpFX+sZu/UmnmJtNe8gQwtb6o
         Wnc/BJCRyqpt07jZgbU7mEzb0Hx7MgAUsKcnD5Wp0bZi0dbn36wU6M8OyEFUqZXvkzQ5
         ysnSxiWIwwL3Ogdyc5xfaeZOY0gc+1jF+RdsIfcYJ3KoWaSJTptn1sskayv4XdSkOsOE
         UvSQ==
X-Gm-Message-State: AOJu0Yzl6bpSs7QSEVYq6qP1+qCnPj59W2C/jEYXh337KBWf4LVo8UcQ
	14CRImlKJI9KHjnIhrmJXfMHeyphr1A4Ks4TVODfaFu2z05tTBXmSaXWL0WsQWJeSw==
X-Gm-Gg: ASbGncvI1tTUXEJPPPyPROo+mDUBr/Af+4WoOOlXgyvg6rkoDkv0pu8ZqcVAaacdF3I
	j4xCbqF+9WUSZe5U8ymq7rg+8x3S1WEaxTbcYKKQZDkG2AQBLkkDHeKDO+Hi/4sTe4bXXo4C993
	wVHYbE1s9OGvudEENe2yu4fru7WQIgV4VaSX1km0eG6pX+TWelVBdr7uk1ravL1NCatQxWIhYQf
	LZOC7R7zJhFY9XwNhsXkYxo59JiNDW3XxREucGfN7tVyDME7Q0u7U4HGsquuvSSCg5/9inrrvwQ
	DQn9VhyGBO9B4wX2toss
X-Google-Smtp-Source: AGHT+IH8GUBNQD+UUsL0H0NZwdj3Q3FI2UI5kWdxU/pJc+ls9wBtXxoUIwHQI1JmYsqxs5+HD6xfAw==
X-Received: by 2002:a17:902:db10:b0:21b:d105:26b8 with SMTP id d9443c01a7336-22103ef57f4mr258598245ad.7.1739958222563;
        Wed, 19 Feb 2025 01:43:42 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55850f5sm100080195ad.208.2025.02.19.01.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:43:41 -0800 (PST)
Date: Wed, 19 Feb 2025 09:43:36 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: [Bridge question] Issue with removing MDB entry after enabling VLAN
 filtering
Message-ID: <Z7WnyC2eSFeb8CA_@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi everyone,

Our QE team reported that after adding an MDB entry, enabling VLAN filtering,
and then removing the MDB entry, the removal fails. e.g.

+ ip link add dev br0 type bridge
+ ip link add dev vethin type veth peer name vethout
+ ip link add dev vethin1 type veth peer name vethout1
+ ip link set vethout up && ip link set vethout1 up && ip link set vethin up  && ip link set vethin1 up && ip link set br0 up
+ ip link set vethout master br0
+ ip link set vethout1 master br0
+ echo 1 > /sys/class/net/br0/bridge/multicast_snooping
+ echo 1 > /sys/class/net/br0/bridge/multicast_querier
+ bridge mdb add dev br0 port vethout1 grp 225.1.1.10 src 192.168.2.1
+ echo 1 > /sys/class/net/br0/bridge/vlan_filtering
+ bridge mdb del dev br0 port vethout1 grp  225.1.1.10  src 192.168.2.1
RTNETLINK answers: Invalid argument

From reviewing the code in br_mdb_del(), I noticed that it sets the VLAN tag
if VLAN filtering is enabled and the VLAN is not specified.

I'm not sure if the QE’s operation is valid under these circumstances.
Do we need to disable VLAN filtering before removing the MDB entry if
it was added without VLAN filtering?

Thanks
Hangbin

