Return-Path: <netdev+bounces-104603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAC90D8CB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA821F2528E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDA15689A;
	Tue, 18 Jun 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOy5JeVs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8084F5EA;
	Tue, 18 Jun 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727115; cv=none; b=LTXmfNXgyfHUcK4i6TaX/oBTzl1SAIqgVi8Y0rfLY2+M+E3yxkbXFQ85cwWjeSLCos3aP2Q33dZzt9CQqM1LcWO4MhtOnXhZWRnpHUkXMirZgJzMBitGH6HI8E8TAIIWNLgaQXTlYaERa/h2eZLGNSYKzQ0XoKsKPo/vP9H21E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727115; c=relaxed/simple;
	bh=2hmMSMcK/DYRjUA5lhYtRVqQYkfz7USAMb6rWWQ3auM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=a7NtX9hiKEF4CFLTZzfttGIbYAgX0RGrgk7Q6g095Xvwe71B1P9PDCBd+tWqw0iFqse6CQCKLXTCZqxKBbVyVKtQaC+Wn+Seeuw31j90Wh1HeAozCv1QrGMvZuh9eX8FgKY7qa8/d1lzOXemTfP7BHDdSSdnZCi8Re75QVeGQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOy5JeVs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so7011970a12.2;
        Tue, 18 Jun 2024 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718727112; x=1719331912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdhfQI9T5+yxPiraAgbpmOt7qEOjgccH7WBORNtfHfE=;
        b=XOy5JeVsltAB8Kdw6lBOYVtRkgs8gb6MTyYYSJwMrVGFF6ZebYByThmCyJoPOFvCqK
         nQwOLQEdJRcQ6XfUgtN8ocq3TxUTBYhAob4/Itnp5bdVrvmfk1Z4XIylsRxiTct6CWm4
         FRnBVqUPcIo5P1T1w7YOkVOw5HOYLhXLN+682YFUyIwrupDjj/u9veyRqjKod0QVuSw3
         zzNm3KgCIxiBEl+JCMPnZq1+mqD9vRwjrayTVVu6tvEe3coRePCPiFR52yhzEjCZNiEw
         9h37Ya/HxV+5MmX0gF15ux11Hxs5N6Q5M5eUSQpIg/0dw+wci1wmL48+I7l0IbrV1KJb
         FEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727112; x=1719331912;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vdhfQI9T5+yxPiraAgbpmOt7qEOjgccH7WBORNtfHfE=;
        b=vgQvB8qNMlyq+x7O9cf+Sgm7cOkm7DyveH8k6wbBbPTyxeMXhrts6YgpXvPhTiNjlq
         RbuCT+OSX1HrqpTK+5/bqaVFn0aWwax5jML1bu/y8MSTi1mjCMkgdddkrwpQgyw6G8iO
         s6zB/bXdAVMK0DcxTXNH0gDb5O4TqJNHiFAFkdsKx4vAHxybmoPel3GNdOnR0r0lRugf
         D4X0nZkYObosrtcZm7Yo7OIstPPs+lCi9hrzKEPzYezn9bFeuaHRMzVRKx5aFPo7Urfe
         +vUNR40DNm0vGXyESwTudOP+vUSn+i8S7PUj7HwBziMuR7R4boKJhICMhb+mHfg11TV2
         2Ygg==
X-Forwarded-Encrypted: i=1; AJvYcCXBnL04FdD5yUJN2LZrIzMi+Q1fVaDUl7Zs9AXFfmZyVzlGclDxKFZMRJusPni+Bav89Va+T45RoSUCENQL1lPkPMYxVd3DQ8ff6vLF0Uw+kK8K7QhHSHiZvKW/xGUsIDWaL64MACrOquOig9pUpKIRGex9Iih3z5hD6CJX0hK7zg==
X-Gm-Message-State: AOJu0YzYQJ0Hf6fAdSDoXJjwacG1OJKmM/x9u5NncwioGPCZuKp3ZpTi
	fltibpkg/bYe9PMyYRr9nl7LwKAAnVq4EXkOJrbv/Pb/EBgjcVlJ
X-Google-Smtp-Source: AGHT+IEfZ9HaFQBufIL+uJmK6fz39+P64leJ9sWW5fe/okGzJN3xQA3FngvVzo6bSVhv/MbpbmaRQA==
X-Received: by 2002:a50:8a97:0:b0:572:7bda:1709 with SMTP id 4fb4d7f45d1cf-57cbd649655mr8559509a12.9.1718727112118;
        Tue, 18 Jun 2024 09:11:52 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb74387ffsm7997213a12.81.2024.06.18.09.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 09:11:51 -0700 (PDT)
Message-ID: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Date: Tue, 18 Jun 2024 18:11:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/3] cleanup arc emac
To: heiko@sntech.de
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Rockchip emac binding for rk3036/rk3066/rk3188 has been converted to YAML
with the ethernet-phy node in a mdio node. This requires some driver fixes
by someone that can do hardware testing.

In order to make a future fix easier make the driver 'Rockchip only'
by removing the obsolete part of the arc emac driver.

Johan Jonker (3):
  ARM: dts: rockchip: rk3xxx: fix emac node
  net: ethernet: arc: remove emac_arc driver
  dt-bindings: net: remove arc_emac.txt

 .../devicetree/bindings/net/arc_emac.txt      | 46 ----------
 arch/arm/boot/dts/rockchip/rk3066a.dtsi       |  4 -
 arch/arm/boot/dts/rockchip/rk3xxx.dtsi        |  7 +-
 drivers/net/ethernet/arc/Kconfig              | 10 ---
 drivers/net/ethernet/arc/Makefile             |  1 -
 drivers/net/ethernet/arc/emac_arc.c           | 88 -------------------
 6 files changed, 2 insertions(+), 154 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/arc_emac.txt
 delete mode 100644 drivers/net/ethernet/arc/emac_arc.c

--
2.39.2


