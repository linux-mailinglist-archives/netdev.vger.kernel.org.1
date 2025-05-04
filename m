Return-Path: <netdev+bounces-187645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D296AA887A
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F30E3A92E2
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA81E3761;
	Sun,  4 May 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="ItZyaiLj";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="ckH91us0"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1AD185B73;
	Sun,  4 May 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379783; cv=pass; b=cQp/mb8cuEoB3UvQB4MF60Su3Vqfxxur3rPu1hHWbrUns+Sa4/ZfJBtRDZUNxQstuMxOumiNu8t6BdIrw6VvmJ/tMGYVlKuYznM9B5VWHSVNKwwuV349SuDR/OBang9cf04x+Tb4CBfkYyf0OYFfzxx5rDhvEzfZY7JZ32dHoTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379783; c=relaxed/simple;
	bh=jJKDNzXtKBCS0HUyXjCv+SwHQOVAU8vhblrbianhQu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bxo54kfWcZK+VNW1HxfZq4WRq6XbX/2YekJlg49KxopGUdxW/MiwC3rrv4B7DbeGIeFbzvUWaXpCelVEMBH9sD6UZP5JA9Ogv7hH+K5hNNjLfXOiXd36PM0Eqcjg2cMTuEN7VReF5LppyXNTW/XKk3QcmO4DrgpH/iWysP3cAAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=ItZyaiLj; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=ckH91us0; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1746379771; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DGmOqG/FY5zeZ7yo6/5dDagkBahmcdlEuSdeM7TERplkeeKbMBaG0kg8D8m5rZnSXr
    gGou+hYs42q8ppqOE9x1wyWh0c+nNW3NI6l1XeK8lTThVs9d/wwKRCAGw8oLAftvVKMH
    716SSFe91thou/Fs699cCi1ENOX2v/TybDHe/4NrQ8KxkBzRWYmKqBfsjBEHA0x4jyWb
    0uHmkHZ3ufeVB9ttfcZcpZt54+19jyH7c0/amjN0mNSofZ9a4ZJ5AqfYfFJuXbMfHobl
    IEhhKElTitf2a+mu8HtRtHAjeTvKQ9o87di1y3QNKwAwlr7jqtgWHhE6zjhku+zQxnpJ
    Pa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379771;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=W0SKc7oupxmOFLst8fPJxQqK9t+U/JRXtklMlKkdpRI=;
    b=QCWW/eTlDA38ekFyp2Mf5WFLoLT65T+rwGgf7AAf17advbg10nW2D3Oq2H5xKGb4/i
    GU+ooxXyYp4xt9z8Ara5dcz6gP0ZKli+UZnjUr8nwswFzih/gHccLkSkbuyXEabhFWvD
    u3MKh5tk1L2BD/ZhT5s3QX9kNxo467Ebl3+MLqSTFcILJK6ibYCPvBiUjggevqCY3rKB
    i3GB4ZWuag/wAcjH3oJwuc4lR/dt0XrDw5Yt+pnvdTAnC0m1w4Tht6spvBejGVA+7G93
    0iJkFYqyz498r+mWFXoGaqzoYKDpYoiQg2pIJqIa6YOW6eMghAP6AQkKRkiKRaBDAkUk
    80lQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746379771;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=W0SKc7oupxmOFLst8fPJxQqK9t+U/JRXtklMlKkdpRI=;
    b=ItZyaiLjnxJYAmN/5O8NQ31V0zSHJZNC2SwBL9YRDJVcAHN6EDAXgvQbXfdzL+HGj8
    1aWbIxJh8eiak4bnpIrpjzsEIv9EMBMgo/225AViXjGFumHJFbBKneK4DJsZ79nVrMWT
    oBHrd3HAxCXbdlaHVoAkCbCgdKsZgxGVJ1+TPqNHjd2Kq11HQox9KKuoO7IRUuEsLt0W
    Jz1Tkc/5iaIU2BzNT07DLshn2FYGH2rzrafx3BQzYETf+carzZi71A8qeg054lLnVufh
    0SifgYgXQ8plXFNH0B7YaylowhySPZ/nhuh22AMm22i63glOAAYJmev2S7d75gN84RCD
    RyMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746379771;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=W0SKc7oupxmOFLst8fPJxQqK9t+U/JRXtklMlKkdpRI=;
    b=ckH91us0GOj9uAFlVOkc3hMsdd6hh+0cweu9xn26nFfQdPTNPVMYNEGptI4e5ZCK/l
    280HO0JG9qQg2MicqNBw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35144HTUz9F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 4 May 2025 19:29:30 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1uBd9d-0004NK-0a;
	Sun, 04 May 2025 19:29:29 +0200
Received: (nullmailer pid 243222 invoked by uid 502);
	Sun, 04 May 2025 17:29:29 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v7 0/6] net: phy: realtek: Add support for PHY LEDs
Date: Sun,  4 May 2025 19:29:10 +0200
Message-Id: <20250504172916.243185-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changes in V7:
- Remove some unused macros (patch 1)
- Add more register defines for RTL8211F (patch 3)
- Revise macro definition order once more (patch 4)

Changes in V6:
- fix macro definition order (patch 1)
- introduce two more register defines (patch 2)

Changes in V5:
- Split cleanup patch and improve code formatting

Changes in V4:
- Change (!ret) to (ret == 0)
- Replace set_bit() by __set_bit()

Changes in V3:
- move definition of rtl8211e_read_ext_page() to patch 2
- Wrap overlong lines

Changes in V2:
- Designate to net-next
- Add ExtPage access cleanup patch as suggested by Andrew Lunn

Michael Klein (6):
  net: phy: realtek: remove unsed RTL821x_PHYSR* macros
  net: phy: realtek: Clean up RTL821x ExtPage access
  net: phy: realtek: add RTL8211F register defines
  net: phy: realtek: Group RTL82* macro definitions
  net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
  net: phy: realtek: Add support for PHY LEDs on RTL8211E

 drivers/net/phy/realtek/realtek_main.c | 269 ++++++++++++++++++-------
 1 file changed, 201 insertions(+), 68 deletions(-)

-- 
2.39.5


