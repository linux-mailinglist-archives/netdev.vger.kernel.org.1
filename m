Return-Path: <netdev+bounces-179562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24EAA7D9C6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6071188C6D3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BF22FF4E;
	Mon,  7 Apr 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhBcz9C7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FE22A4D6;
	Mon,  7 Apr 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018506; cv=none; b=NLISuHtIMpf/3SdnsJZ723jXtLcuMgXErxZljWLeU8KelNGCWJx0XiuTynFo7JZv4SooECfp8yYnVsL2lqsgfdju5DedG08T0Xhh9OkWM1omHTpllsLd89MiiI2Qkf0/QqWqRYDxXzL/lWkHWLdYEP8d2GPG7TvMqxy/yIBEHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018506; c=relaxed/simple;
	bh=NA/Nd0Ddf2jORatQD4g6yIs1ne9f1uLXUzl99732yc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIiZdkTinlIfmmrpJE/O1C/v7u2gbhVWTKKKwepn0j//n/nw7RZM06lHEbXX8JRHxHWI7zG+MMyvkFLfc+2UVtDPfStNy1SE2H/4w76grS511BQf9Aq39QMxjOZNb8KDtwPoRbxRKK78UGbpzL/smrhyu9XoeFXC5ZCKoptHhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhBcz9C7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224341bbc1dso34729935ad.3;
        Mon, 07 Apr 2025 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744018504; x=1744623304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3fVOy8mns/9JIDsaRuopOAvHNx0fO3H/yc9m6/qJXA=;
        b=dhBcz9C72nOh88cyHuVKzc9Mj1lJ90mOTZ37LCkrBfP8fgPZYxxFwK7oglW6qDjoaW
         IdCS9gABnZ0jKW08RY4q0lR1Z11SjwkgLVK0N+8v2W1vuM0B1SNalVNEcG4m386Eknjz
         qM6STO4qejUT5Ed7G1UWNyCGyjQVata3oDAnUsby1UWamTfXluaNeZSJz7IwtK2kaMVj
         MeLjPLTK56ySUSK63JzT5NfNCSyNOzqfpOT4BXonbn5IhW9778aW4WkMHZGI3NUPI6lF
         5DjTp8UgFlVxSpAgMhhkFFFX9CUdLt/tUufP56bDa5q+nKx/0qQ/6/oY/kiOiLdCRCyF
         bjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018504; x=1744623304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3fVOy8mns/9JIDsaRuopOAvHNx0fO3H/yc9m6/qJXA=;
        b=Ja/p0IHTifmAPbYpYhDRNbaOcC6qQFQM1+Fjy2OYGIiLPjfLJXaBYrQjCbqN5JwbTN
         MeXKT3Un2v+eKP4UxQAuN4Dun0SDMEtA/KMCTTJNhCOz02EFZZG4uXbc8h5yE2rucTBK
         IQ8l/KyORlM24HUjP/xxXYhSyvo52d39/962zazhvI6UAv/znSeXnzytDtsWv+ovxm/8
         /oN3ajVBhmi2aiJit65CTMppycgkbFqSYxyhINeTKnx40iitAHuZXaG+eadTMZGmCn4X
         kiiS67JGV6entGcUNO80kD23QdU/abV4d4XrkkUxMU8OgYIGrnDJfU3DIQHsz0P+W9FO
         aTtg==
X-Forwarded-Encrypted: i=1; AJvYcCWdQG7/skepdFaS8xFPyaExNRev4w1J2M9LS2T+WhrUDSKMsOxVCIVjlsvE7F5GeDrmvKCqtghag4I7pRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye36hjuOVG8WIsk71dyB6o/nfNDtPpSuze6rxyie8aCtST5fV6
	zy/EmI0Ek90MMzLKp3Rc6MGK9eUmG/s5YC9LpSNaLaDgOXd6sX3q
X-Gm-Gg: ASbGncv2KUeVvG4hCyX2BADFhbZiHmZUQ+L/bis5TyZH0mIIvDZilYY95fjqo3y3AWl
	xLt71KZsRqIpAwxoc8xqjoH16GYRYRnbj2cjjqHM+PeiwqpNdqz8jbvO66+sNkeAOYNRKLE6qMm
	QAaba793Ha3IqWp8MYTUUXQ5mu2B+mWJ1nJ33ikercMDyhUMW4GWyW4dct5n32rVyZAhIdS6xef
	nOq25ufkm8QbYrQbP+J+nsOikWgX7hbttX4IOioSJ1ylGQbiSkgT5hhHHX3cpRgdiXo+dcVXsBu
	7c/f/ZBBawSfF+thzCxZ2YPPel0XKeVb12HKEmh68b2LgCmVyw==
X-Google-Smtp-Source: AGHT+IFN5Aj47HVwSZNa0w+mDnCZklaD4x92z/LhnYjRYcRlKKi9NZjwjG50B6PZzoYQmqv6RINMmA==
X-Received: by 2002:a17:902:d485:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22a95529550mr137783025ad.12.1744018503634;
        Mon, 07 Apr 2025 02:35:03 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada7csm76473015ad.31.2025.04.07.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:35:02 -0700 (PDT)
Date: Mon, 7 Apr 2025 09:34:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z_OcP36h_XOhAfjv@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3383533.1743802599@famine>

On Fri, Apr 04, 2025 at 02:36:39PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
> >fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
> >active slave to swap MAC addresses with the newly active slave during
> >failover. However, the slave's MAC address can be same under certain
> >conditions:
> >
> >1) ip link set eth0 master bond0
> >   bond0 adopts eth0's MAC address (MAC0).
> >
> >1) ip link set eth1 master bond0
> >   eth1 is added as a backup with its own MAC (MAC1).
> >
> >3) ip link set eth0 nomaster
> >   eth0 is released and restores its MAC (MAC0).
> >   eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.
> 
> 	This step leaves both the bond+eth1 and the independent eth0
> using the same MAC address.  There is a warning printed for this, and
> allowing the duplicated MAC address assignment has been the behavior for
> a very long time, and to my knowledge hasn't caused issues (I presume
> because swapping interfaces in and out of a bond willy nilly doesn't
> happen much outside of test cases).

Yes, until the NetworkManager become the default interface configuration tool
on some release. When set a slave down, the nmcli will remove the interface
from bond... This causes the issue to be triggered more often.

> >4) ip link set eth0 master bond0
> >   eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
> >   breaking the follow policy.
> >
> >To resolve this issue, we need to swap the new active slave’s permanent
> >MAC address with the old one. The new active slave then uses the old
> >dev_addr, ensuring that it matches the bond address. After the fix:
> 
> 	Which interface is the "new active" in this situation?  Adding
> eth0 back into the bond should not cause a change of active, eth0 would
> be added as a backup.

When do fail-over, the "new active" literally. E.g.

> >5) ip link set bond0 type bond active_slave eth0
> >   dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
> >   Swap new active eth0's permanent MAC (MAC0) to eth1.
> >   MAC addresses remain unchanged.

The new active slave is eth0 here.
> 
> 
> 	So this patch's change wouldn't actually resolve the MAC
> conflict until a failover takes place?  I.e., if we only do step 4 but
> not step 5 or 6, eth0 and eth1 will both have the same MAC address.  Am
> I understanding correctly?

Yes, you are right. At step 4, there is no failover, so eth0 is still using
it's own mac address. How about set the mac at enslave time, with this we
can get correct mac directly. e.g.

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..0d4e1ddd900d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2120,6 +2120,24 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
 			goto err_restore_mtu;
 		}
+	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
+		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
+		/* Set slave to current active slave's permanent mac address to
+		 * avoid duplicate mac address.
+		 */
+		curr_active_slave = rcu_dereference(bond->curr_active_slave);
+		if (curr_active_slave) {
+			memcpy(ss.__data, curr_active_slave->perm_hwaddr,
+			       curr_active_slave->dev->addr_len);
+			ss.ss_family = slave_dev->type;
+			res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
+					extack);
+			if (res) {
+				slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
+				goto err_restore_mtu;
+			}
+		}
 	}

Thanks
Hangbin

