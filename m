Return-Path: <netdev+bounces-183598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78BA912ED
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160B7190692E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6492A1E3DDE;
	Thu, 17 Apr 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX1CNli6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F71DF725
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868556; cv=none; b=Rye7wMgmoIi6aO5L63PtFQbD/26FXyEnoU74PSMM/ilxkIY/RYRdlSooTdfSo8MWjA/dgIVCidRlCz+IJ0vyZTT8+IhLTxjigfXksQ4hb5zfRx7kyIEHQ9Y7S2BbFYy+HOIFHyZgXgf5ECA838X8ff2sjnOyQit9XQAI7Awdzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868556; c=relaxed/simple;
	bh=XpZS+lby2tKePQURWtRg1jTPKtFRwEIaSrI4eOcvF0E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OPVOrlFWahI+sDjiSeESDbrPVVTJJ+optNgR/HOOHd7XmugNFAKaPqRSZQCkOt6lYlCktnAOb5AYdUnNvnJAKOJhE4K7JM/Z1XREdp+N/nNlxKdmz+d7Gb2rYUu+kB9cM6FdXpxq/IgkTdOe93hK5lnmZ1Yo0dogvYWvqtzaE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX1CNli6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so302952a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744868553; x=1745473353; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9vBZXXH5xklqqIAY+JM/BqTJHdsOIlWi5Ak9420uc0=;
        b=VX1CNli6ZclCLbnnVlWm8M78h87U3+XeA/iy+M3uPVXtqTe1gEb8A2YzItXB1hZpTQ
         zpDgQ9O64Hl6+zTLYqScurnSNjpPsm3G6V2dM7w5iPnC/bsAi/VWF5HWYfpNeHugNr8W
         Ft+Crm5sUGRyKLsrvI60Nt7AbchzsN+a9aHYkuYGXhefuKF96d92mT3C7c7WbdFgwczb
         NUiRdP6HQKyFipGo1nqYwZuDRdCD3dvCqSPyncxuA/I2Ci/H3nZaF5h8qCBJOEnwasfv
         xKsm+1UCNOnB+FM0IGJR5XHNuBAyjggiVpI1Z0EtaatJJy5pcl90gHQv+0KDxn4BDqlZ
         /8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868553; x=1745473353;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9vBZXXH5xklqqIAY+JM/BqTJHdsOIlWi5Ak9420uc0=;
        b=LiNsGp1vJTv6o5MHuKDT6pABddKVfpG11otlgx7jqUPCud0FwGwEhKDX3xrGCmkDMA
         sTIswaO7FajwBAokL4bEp3gz6MF79kXdNRdTRHvVCFVHY/wANIRU4l5qFnBTT1vtQ3mC
         TV7/h5ThYAmFOdoVR2A/VmXpxKsNRE2Ojk/bcQV5fj2FnOf5TTy0Am8FFeYrPArOiBdY
         843x8dX8hEDfsKz+LJlCuDYXHTjKIH18COC4HCIbcO7pN1Mcg1lrwSXhfw5ANC9mX+51
         v9NmWAnVg+HnNfwvN1z+6zJree2ahX98laJcR4f7o3h7iDizbVg2p585hYMUcSBzI7VB
         IM+A==
X-Gm-Message-State: AOJu0YwYLwDw44GqR6E+248raVeeUP6SJvuGCYybbhUTpQOo3rQp0aKW
	Eu6Tli2CeTWlSOr8gtO9CJDJTA2gI5/tAz0BrjPrjDPewqE9grW1nynEXv1VD8RcOnqyVAMdE5P
	KMST1AiQv4FR5EvnrNv6T9lnmyR0bFb+q
X-Gm-Gg: ASbGncuP0QLQrxzisrz/jWGcTIYwVTdEG2bZfzG1xJ9CqUFQvve4CCvxKV49xG5wYew
	84DARjeY70maQAbk0h61p9WUS14JIbngnhy+/rLQzmWbIxTB9r2BJpSutCQ/EEOBLOZdYk1WxZQ
	nJ6IX0yV/E5kpu8J/cL0odH7kFj0glgjBe5RyBO5CjMxok4zxICDZGiPpF
X-Google-Smtp-Source: AGHT+IFbufaKsW8u3/j0RsM0jF8acq0+tyKV+9CA0Dd/i1FqbL2uw4LLo+DyjUG2huxNEWfWMq0iuWW+FE2j4XV1E/I=
X-Received: by 2002:a17:90b:534d:b0:2ff:7b28:a519 with SMTP id
 98e67ed59e1d1-30864172548mr6876272a91.30.1744868553322; Wed, 16 Apr 2025
 22:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SIMON BABY <simonkbaby@gmail.com>
Date: Wed, 16 Apr 2025 22:42:21 -0700
X-Gm-Features: ATxdqUER0hYodlt7RRRv9bfQNdF97WT7WI4UXBlMepp9bNniGJ3ZH8a1gy9Crzk
Message-ID: <CAEFUPH2HVZDxLmhqfmiGnFt15KnhpWwRVswMzmTDxY7-zBub2Q@mail.gmail.com>
Subject: query on hostapd
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello team,

I have an issue with hostapd on bridge vlan interface (with marvel DSA ports)

I have a linux bridge interface br0.50 (created using bridge vlan
filtering with br0 as master bridge) with ports lan1, lan2 and lan5
(DSA enumerated ports)

br0.50 have an IP address 192.168.50.2/24. The DHCP range for the
clients is 192.168.50.1 to 192.168.50.100.

Radius server is running on IP 10.20.0.1/24 and lan4 is connected to
the radius server. lan4 is a member of  br0.40 with IP address
10.20.0.2/24.

A laptop with client certs is connected to lan3.
                                                        lan4
radius server-----------------------------br0.40-----hostapd----lan5----------------------------------------client
10.20.0.1                                         10.20.0.2
      br0.50  192.168.50.2


My hostapd configuration is below:



oot@sama7g5ek-tdy-sd:~# cat /etc/hostapd.conf

##### hostapd configuration file ##############################################

# Empty lines and lines starting with # are ignored



# Example configuration file for wired authenticator. See hostapd.conf for

# more details.


interface=br0.50

driver=wired

logger_stdout=-1

logger_stdout_level=0

logger_syslog=-1

logger_syslog_level=2



ieee8021x=1

eap_reauth_period=3600

ap_max_inactivity=86400



#use_pae_group_addr=1





##### RADIUS configuration ####################################################

# for IEEE 802.1X with external Authentication Server, IEEE 802.11

# authentication with external ACL for MAC addresses, and accounting



# The own IP address of the access point (used as NAS-IP-Address)

#own_ip_addr=127.0.0.1



# Optional NAS-Identifier string for RADIUS messages. When used, this should be

# a unique to the NAS within the scope of the RADIUS server. For example, a

# fully qualified domain name can be used here.

#nas_identifier=hostapd.teledyne.com



# RADIUS authentication server

auth_server_addr=10.20.0.1

auth_server_port=1812

auth_server_shared_secret=test123





# Enable CRL verification.

# Note: hostapd does not yet support CRL downloading based on CDP. Thus, a

# valid CRL signed by the CA is required to be included in the ca_cert file.

# This can be done by using PEM format for CA certificate and CRL and

# concatenating these into one file. Whenever CRL changes, hostapd needs to be

# restarted to take the new CRL into use.

# 0 = do not verify CRLs (default)

# 1 = check the CRL of the user certificate

# 2 = check all CRLs in the certificate path

check_crl=1


I observed that with the above configuration, radius server is not
receiving any packets ( interface=br0.50)
If I change interface=lan5 in the hostapd.conf file, I can see radius
server is receiving packets from hostapd.
Do you know anything I need to change to work with the bridge vlan
interface for hostapd ? My design is to have hostapd listen on
multiple lan interfaces.
How do we make sure that before the 802.1x authentication is completed
DHCP packets are not going through? Is this handled by hostapd or do
we need to manually change the port status or by iptables manually ?

Looking forward to your help.


Regards
Simon

