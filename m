Return-Path: <netdev+bounces-119019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E24953D3F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9241F21B38
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C30154C00;
	Thu, 15 Aug 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsYvsf4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157B1537D9
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760188; cv=none; b=L9bYHaXUZiITC8aDSrIcLWm2ogCnT2Vt+1QcVi9iPFN/IGhJdjmlpoqGdBTF9jciShZ4FNWyVdr6nV4davPDjyDRMMtxYk8LQ58DMXzaPVayw3Hg4o15MB0wyorxoNPO65NmKdVSbr6qRFnfRKNZdo9M4UWX+0EkSK4vdHTYkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760188; c=relaxed/simple;
	bh=AbPYIAkQonETuo5UQNnFIBdUW0PaHWhGBqUWD7ojty8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cCmK6V64eEv+xzfRp8tkdWFqv53ZQt6fMBZviZBDD+G5dd2asMWzw9EUZi2hFmD6O+Y89mwB8njrbfFuX1qYp418Gs4yJNysoMJMaQ7WDxVn4M41/PxPdIeM30QSungKb1YUm7X5sppHe9ABEXDG6eBu/NvRIa2LLOiEuuVI0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsYvsf4G; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8384008482so124044866b.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760185; x=1724364985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AirDdrQKleTOAYRxGXw40qeI5AewHiQat9aodju4q0E=;
        b=FsYvsf4GOL3lyLSpAScLZ9BhPe+ySErmWGX+nxDKNaiPTzpBy2meOAvN7eOmuSB6kh
         0rGqgJtg3zoPyGP8+3yo/VyGjjK8LuAn2NzKP/++nkT1mkZRQx/xW+5iFva0PzIFzBTX
         hy2+t8BuLTaMh1RGrcqyzhNCNpyTaHp5tv8nseraPpxXlynXFDETuTd2xnqD+ePx6ymh
         g/IJioF9RJke/fIuoE9c0OcGwjz5fsBbXR9IdadmbMRylngQq5PKwg21cnEobKYq2MpE
         kbi/gm1jzeypFTo3eeQfj+CSNsN9QWDW5iZ7JWSuiV1+vvtC08oTVcxSkG64/XhU02Y7
         7sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760185; x=1724364985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AirDdrQKleTOAYRxGXw40qeI5AewHiQat9aodju4q0E=;
        b=RDOMN6aPkHf3ZyRmNy8ur/Ll3fkZ1BvxER5xU+9rVtFuftws71sK4MhFWdC6KuwvY0
         Q/dQQ/ao6ZqgxQ8Um32cKjbo9D+zrjIQrdIlpV6myHhggxkPTawRqHkJ3RYBsow4aZWX
         aRVcHui4byIU7eCxEsilKsDgD98gJa91G+8/FtqiPx8L4h/b6BuDGEieMb3Hh5xU+08+
         D0blZrMBFIbhxsGoyIrQAusQWoAYbYrQjdTq+AVb2Psvd4R1oKGIjFX5Sh5wnJp+AI50
         Hhsgknu5xagxa9gPrvsy+YPoKQVndsjiLe57WJ1ddlIM9F9jLqeJt3CIo4PjxVgb9flh
         He1w==
X-Gm-Message-State: AOJu0Ywf0008PqTCQiRXLSP9MUgFMB623yskt2faLVrLBuu4NPIcM312
	ELomyWi8KUSzdOC6FRUlDkiowh/I2gWsk3A3lPBgaNyNbq44zpkNdxi5ig==
X-Google-Smtp-Source: AGHT+IFVI7RI1KXcKzWbWWikg4dSEYJvUx5/FIoranbzSuq5JP2R0pWQYOoGYfce3qfrqv9/qsa1IQ==
X-Received: by 2002:a17:906:d267:b0:a7a:c106:3659 with SMTP id a640c23a62f3a-a8392a646a8mr68642366b.60.1723760184417;
        Thu, 15 Aug 2024 15:16:24 -0700 (PDT)
Received: from eiktum.localnet ([2001:4c3c:702:b700:6b82:fa10:6280:55f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947123sm161901766b.178.2024.08.15.15.16.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:16:24 -0700 (PDT)
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: netdev@vger.kernel.org
Subject: Strange behavior of command ip
Date: Fri, 16 Aug 2024 00:16:23 +0200
Message-ID: <3605451.dWV9SEqChM@eiktum>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I have the following bash script:

#!/bin/bash
getipv6() {
nmcli con modify "Wired connection 1" ipv6.addr-gen-mode eui64
nmcli con down "Wired connection 1"
nmcli con up "Wired connection 1"
/usr/bin/ip -6 a
}
getipv6

When I run the script the output is:

Connection 'Wired connection 1' successfully deactivated (D-Bus active path: /
org/freedesktop/NetworkManager/ActiveConnection/23)
Connection successfully activated (D-Bus active path: /org/freedesktop/
NetworkManager/ActiveConnection/24)
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 fe80::dea6:32ff:fe55:12be/64 scope link tentative noprefixroute 
       valid_lft forever preferred_lft forever

When I run the command "/usr/bin/ip -6 a" the output is:

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 2001:4c3c:702:b700:dea6:32ff:fe55:12be/64 scope global dynamic 
noprefixroute 
       valid_lft 4126sec preferred_lft 3466sec
    inet6 fe80::dea6:32ff:fe55:12be/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

Now the global IPv6 of eth0 is shown.

-- 

vr.gr.

Freek de Kruijf




