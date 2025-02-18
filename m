Return-Path: <netdev+bounces-167425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7ACA3A3DC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADABB3AD7C4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D11228CA5;
	Tue, 18 Feb 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cB5vqLgx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74157246348
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898826; cv=none; b=AwC+9QK8h456ZckNZRjG05S+OFmAIgJC0mAKc0gDOc2H0yABiwQtvxboGpQQG12XcNXcGwdYc5axMCOiUzEVPxw6jCTUYTiOAN5fjvF0jmVozJm8NjNZGqq0kx7n9tR/EhaAlrNow/ez1aO8ge8SnJHm26KRG31nnjWEi6/D+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898826; c=relaxed/simple;
	bh=KD5f52kSOGy6SFAzSmWw7xexUpKWQr50ONQIB2LQYfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5SRHYOXCuKiOmuUbkEye0EmlQFtw4mPhY4pWJjd0zUeCs3NO4wXNnaEgQJUgmwnfZzcTYFXlkl7xfLvs+0McT1mwV2UZu3zmegAAmvtx28XjoffC8+0SOD1Z7xsJPgUiviANRGK8zgxU7fM7A603ON4JU1QGqx57VqjZ5wHroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=cB5vqLgx; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-ab7c4350826so104008366b.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739898823; x=1740503623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwgFh+hIFvSzOS/rK8aiurfj3uUOJ3o5txVxE1dKC8s=;
        b=cB5vqLgxMGFnqTLtk08FVNbQ4l4wXnGhRr8Fd2DF1JFC6LvfvnMJ3jQ/Vfett5VXSV
         LorHEPNlAzm4GuzIrW/KFYD83Wu9Gy/Mj1wdqaXjqhtlgwEy1r707yHkUhlJWhVidbnQ
         IIbb/2NK0+LN7in3jYX9E2SMOJ6s/7i4hkTn8FYgYjTHh/taiKYQuMz0sUkjBnPNYewk
         1ce9UoL5/URY5rOwh07wKq+KXJhMrpdQ7Qfsfu1zxpk5jzzIXewJceM+Em5v/uIVWAea
         m89hBe+OwmFUzMWuPM49xXzuTWAj54E6lAxphoM2M5gfySTTVBwulyw+CJO3tJw0aeXn
         KEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898823; x=1740503623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwgFh+hIFvSzOS/rK8aiurfj3uUOJ3o5txVxE1dKC8s=;
        b=lVjRL4gxycp1ejQR8Vf/LJ1jfIA2XmzIoJyf6b23YsszIUHAheNLGYMB5tO/369XD4
         8XH43IyYXU55iidJK/yxneKapzQDRf+7zQXzrbr42QoTsW5+vxCSN95ykhrhPS0O79KZ
         L0nECA9Dq1QSsc+ogGSGmx6WwZoHkydi/ME1rMK/2TJpJR3DAjKP05FL8LiIiXuQMN7G
         PUR3Q0PbW8K4VNl9A44wNAhD8GrD9wfTwmilzX/tJxKbAlthuXwv/moXVvST0EZwyoT6
         r5GpzISd9CiU1qv97lJxuVOOyUfhW8K/nka8l27NJT/MKfF2l8tnDE+0FZg6VWWdeNCK
         G4aw==
X-Forwarded-Encrypted: i=1; AJvYcCXutkS/NhxfrQkvfzOIKZzBOZjpe1fgsyVDTlr+O/Scb1qa9Fnl7eK5ZPad0P6ebDmYlRy0ORs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0nyrLSd1DL+a77PlPNKm9NOhpNTneZae3+drrrSuU5CToXsd
	AMXeXdGdrTj5M3aCl6+uDQZfhH6zIaAdw8yfJWfgZOg+kYsV0lsbgVtqzva7RARseEqFOiQepnQ
	3YaUE1RehkuHWaM/akbSYLjBMIadAIQnQ
X-Gm-Gg: ASbGnctrM6zEb/HG96L7pMsq8UCZAMC9GSeftq62uvkp0dSCBqHjyOnwlWDNPqNg2JP
	jh+5EHRE8FsjMIo7hbflY2hu7K456gYB/j7IzQmwPDz8li5M0bex5owR/DkdvTPkGAeYKJ9iXas
	+ZGmZCUy2ZASVmAsPkZnZAYA8rRmC70ZQBUo1xxfRuzEpexrXzjEnUFqthFW2CUSGcCJhjc8jYx
	rgGpefG42ZemkLuLbWn6pqDvBILLgJspzYigVwgosRGGSmne7Y24gG4jEl1z/qnPpfPN3dDTZTc
	a7mGtILnVheAwhz9wmp6SzKQqru8OEVghGkNKNj+cEy/yg7JcGnfPz6VrKzy
X-Google-Smtp-Source: AGHT+IGfeiIoz4nj5wGjOA7G7kS8eac4whBlvLxwWHGB1DT6Ju1igCF3oyPiKz8ZKmaeoyVL5UJ28JH7ipIL
X-Received: by 2002:a17:907:1c8b:b0:ab7:5fcd:d4be with SMTP id a640c23a62f3a-abb7093051bmr579305766b.1.1739898822488;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-abb80c78c93sm55856266b.56.2025.02.18.09.13.42;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 482CD12515;
	Tue, 18 Feb 2025 18:13:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tkRAE-00F4xH-1Q; Tue, 18 Feb 2025 18:13:42 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: notify users when an iface cannot change its netns
Date: Tue, 18 Feb 2025 18:12:34 +0100
Message-ID: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a way to see if an interface cannot be moved to another netns.

v1 -> v2:
 - target the series to net-next
 - patch #1: 
   + use NLA_REJECT for the nl policy
   + update the rt link spec
 - patch #2: plumb extack in __dev_change_net_namespace()

 Documentation/netlink/specs/rt_link.yaml |  3 +++
 include/linux/netdevice.h                |  5 ++--
 include/uapi/linux/if_link.h             |  1 +
 net/core/dev.c                           | 41 +++++++++++++++++++++++++-------
 net/core/rtnetlink.c                     |  5 +++-
 5 files changed, 44 insertions(+), 11 deletions(-)

Comments are welcome.

Regards,
Nicolas

