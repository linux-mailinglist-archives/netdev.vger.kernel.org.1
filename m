Return-Path: <netdev+bounces-166771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A0A3741B
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 13:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3AF3AEC2C
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A818FC92;
	Sun, 16 Feb 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYCiMll0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7D18DB20;
	Sun, 16 Feb 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739708746; cv=none; b=MTE3hIpPiWJjKCatI3EVrEb2+H4YY7Jsewcbgv9Y6v2GeVWLEiu2E+C9zVrzQYO9TXslDVdpApFFhy1S6mExiO9DJKbW1wx9p2PzbebgwF/AbbdQIsO8zBcTe0IwdBfgs67/dzxJzcbwkp+vVQq4FR6fGrbTvpkH+SSGGUAg5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739708746; c=relaxed/simple;
	bh=Bj76VLCbF+M23LqrthO9t0w/jK8xDXfTqynJtKAV3Gk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F1LrcCV4XCOx9IP8AEdQIQY4H7AiceGvKDys3t+meXL7uwQIhsx1unnhn7bBC1QRaU6/ymqGkTL2QsAE3ozIitCUNb9BE31jNGxnhxNlEtsFxP96MgPzUCojNiR5dKIoaopDqieagbFP6jdeSyT2yLZntv/MAfj24YZJ40gpCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYCiMll0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f3dd2069cdso1498940b6e.1;
        Sun, 16 Feb 2025 04:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739708744; x=1740313544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSnYjGPUnvBJRrlMcBwocb2X+d96z+Eph6pBJs4+vkw=;
        b=UYCiMll0qLSw2lwh1GF6sC/tm3bQXh85KpDAlAZP73mXekM/2W73IS1a1XSyxsgI4N
         UvLvGEY7L+Jyh5kKD7eg0WZmtJp4lDrlvQwiNGtvjnwkmoDotnQRoX65LIDtfcjUSZdI
         nOCkF1d5lcWOKWzuEyVOmEa4qZHVkZya3IdiorbQTUaxGmJv5Kiyd1S7pADOXGR1zl40
         jsP5OX4TCnUkasbjf63ZPhdHJ89DUbICF6Ngm1TiowAhwhk1mFDzBS08uXmclzNokIAd
         omkafdLE0yILL4p/A8WKq0pH1nf1QnT8fPeXd6njvghk66+CEwxTktWiIJAmNPyNHzSx
         N0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739708744; x=1740313544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSnYjGPUnvBJRrlMcBwocb2X+d96z+Eph6pBJs4+vkw=;
        b=MS5svKoYQTu9tm9yPe5XUyUpKqRi5WFg8ECcTWBAWaaRK9GPUX76e/irTbyA+kNP6L
         JB8ZlIkk1XT4RZshRqM8uPJUuGyx3GuvAXwNj8mvdHmXhjKrsBat++iRdgkft4jfNbBj
         CTKHjP1RgEn23onfMLHnWagobjjpAx6nI5DY/T1Jc0p0Tfmi+FIKP0yKc9iju2mAUnx8
         0cVT0iTXG3a1HMbW2OgBZMnH8y/g2yE6dPVcO0urHfpzplDxfrNHCB8STNkogdjCrO8t
         zV1akDrAUOAdzVFZZPr60Of3CfMWivT1+FZGgD5XQBogoKJhN2YIq/umNp1W8Mi9VDOu
         bNsw==
X-Forwarded-Encrypted: i=1; AJvYcCWa+5FrtgjbVtJ2QqZvsq9G/P3rLmdqeHJIORcLsoI3vHhkA7Ma+6OoMdgv1H1j59JtHB4JdgzMitXqpVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfQCgdTLZDGweeME8DIj8sUHSQqEeyZrNQecqB1HGg0nmhAkJ
	c+M4MTFEhmSb9AcGOE2d+IPGDfDGvqA1aqUHQpbUCM9v+enDAVRnQRHPCS324zQU4bkh82eLgzy
	1HGbNW6yI9AFTHU63RPRPE+y+KPal2e+MMYyomw==
X-Gm-Gg: ASbGncsa4vJKBpHhV4WmJXuX08WkSnL0UzPLdM/QMHxvQzD0TkNKevBvFtFwFTCFp4+
	GMcugzX6mMnD4WtYrLKnDnWR+bkrqW/3CRsOy1aTmbZyNybJI7267nzuiWXpqy9ikZdthmtM=
X-Google-Smtp-Source: AGHT+IG8fOZSNe+eWtL5qllqzMlNYIgN/e+2mZts4Aos9aWvDH3ndhieI7Y03c/TES4ebjcgrxC7qTEJN3mojqppnoQ=
X-Received: by 2002:a05:6808:1529:b0:3eb:7ec4:f3ba with SMTP id
 5614622812f47-3f3eb08a3b8mr4435134b6e.2.1739708743659; Sun, 16 Feb 2025
 04:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sun, 16 Feb 2025 17:55:32 +0530
X-Gm-Features: AWEUYZkR-AaxoUlta2McDAXfuoLGVt863RNRkh5_8FnckELfAbf--AAUl2c7nIY
Message-ID: <CAO9wTFgN=hVJN8jUrFif0SO5hAvayrKweLDQSsmJWrE55wnTwQ@mail.gmail.com>
Subject: [PATCH] selftests: net: Fix minor typos in MPTCP and psock_tpacket tests
To: netdev@vger.kernel.org
Cc: horms@kernel.org, matttbe@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	Suchit K <suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixes minor spelling errors:
- `simult_flows.sh`: "al testcases" =E2=86=92 "all testcases"
- `psock_tpacket.c`: "accross" =E2=86=92 "across"

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
 tools/testing/selftests/net/psock_tpacket.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9c2a41597..2329c2f85 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -28,7 +28,7 @@ size=3D0

 usage() {
  echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
- echo -e "\t-b: bail out after first error, otherwise runs al testcases"
+ echo -e "\t-b: bail out after first error, otherwise runs all testcases"
  echo -e "\t-c: capture packets for each test using tcpdump (default:
no capture)"
  echo -e "\t-d: debug this script"
  echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
diff --git a/tools/testing/selftests/net/psock_tpacket.c
b/tools/testing/selftests/net/psock_tpacket.c
index 404a2ce75..221270cee 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -12,7 +12,7 @@
  *
  * Datapath:
  *   Open a pair of packet sockets and send resp. receive an a priori know=
n
- *   packet pattern accross the sockets and check if it was received resp.
+ *   packet pattern across the sockets and check if it was received resp.
  *   sent correctly. Fanout in combination with RX_RING is currently not
  *   tested here.
  *
--=20
2.48.1

