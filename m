Return-Path: <netdev+bounces-148585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B99E26DF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B3F16872D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5931F8907;
	Tue,  3 Dec 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yourpreston.com header.i=@yourpreston.com header.b="Tiq050f/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964C1F76B9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242513; cv=none; b=j85pCfOQTVDSg8IEaT+8CpvvxFQCcCEyV2ZVU/OL3WF2sWhr4NGozhpPU7Ak+OsGYC9BJ24f5PY69tmivVy/fW/lvUkFN2wF3ZV5qXsck4RWKouyztlPnLuj2W+9iPsdI4ijFCT+SXB1fwUoBQYBKgsIeG3WJA1gz1AVF9eKsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242513; c=relaxed/simple;
	bh=mPUB+I/N0bH1rni/FXNWh0kdv4orytIeUFOw/U3OBug=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RVkWsGRHtUvmYQyQXfHHC1KskDnQtdR64kxTTSWs0d1PrVLVXlnhlIm3YJQqCF9NqvDHsxVecXM9Fw+hUyXvYJfBdXGZ7JP3zEJDVuC0WMsCKr85a1/iMzLxGPBPa6KvtuxoAWTMbA2wHa86FboMOGjRFmY1NjXKaxZLdSJC4dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yourpreston.com; spf=pass smtp.mailfrom=yourpreston.com; dkim=pass (2048-bit key) header.d=yourpreston.com header.i=@yourpreston.com header.b=Tiq050f/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yourpreston.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yourpreston.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef402e4589so54869297b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yourpreston.com; s=google; t=1733242509; x=1733847309; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPUB+I/N0bH1rni/FXNWh0kdv4orytIeUFOw/U3OBug=;
        b=Tiq050f/52Tgc15ZTwlLfes08bUIDJccDXnTLPc2MIYkbnG6hXjFKqEu1vs1fy2G/z
         QuEWfGulVvo3WaCKOu6BYAV9ixedmC15/l26amMOdYvqkAoKV4JwQ37WQglCy2eEtd8Z
         l2RzpMaLBQPVrvwPzjpasnKeh2nuElrhdfV85YnALORQvHEdd4rOB1GND2GET75kmKf1
         GFJZd0/HEvjtg2xNTThVwB1dKL70r2GPbx3MKWxlhEa2e5p8+q8+YhnvzVK+OmBml9jw
         zGoPuG48dgQI7kY1kWnfnhZpsKbNWkyMq4/FdjT/Xk1CpYuiD23WRHtxxNkqUcuzXauc
         nKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733242509; x=1733847309;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPUB+I/N0bH1rni/FXNWh0kdv4orytIeUFOw/U3OBug=;
        b=nV7mCIflb0YYVHPbV0dQtNUMd7uOc2KWddQcGeBDG1A6MlTnWbv0O1wyMpBPXRhsww
         h0Wn5VFLUEPFKDIoOTnQ5no4HpTABsCOS2gDmdm47CXwkHgMs8sxtk+Ix/4+tFS84NEI
         tRBwRNB3TWg+aMZFDk2aqIGScNzdExW3KZmas8+XkVHbugyRmb2qcADJfGbCcrdDlnd6
         6tEiHIpnecIDhqXNd0z8flzQnuQ0q5Lha+2+bjSEr+hzuyw1dqwMjx9kmM+MUtdavLzF
         ZI58dkQ0LkFu+8FJLRbMnLG8wyJ2/7t16LSsY7i3UiaFUdael1XJDCr/pdPm3e723jgR
         JYpg==
X-Gm-Message-State: AOJu0YzXenKrXlSXer79U+DhOJ1cAQkiu9pLJW6GHyTMG4jEayxrqc1e
	rxi+aZU8Lfidh4I1qka15sdxLttz+wgc0qokbcddqIWJKDXlCLKhKCKiVjRGLX9ScYAWqLDxOvu
	WApfzkf2wHylfwDfaQIVbJYER+TVpW6XZmPu/hl5onIJnGlIYR0E=
X-Gm-Gg: ASbGncsP/bt3rCD0bHHAbxx+Ekh5L0XoozJLM+HOgHgYt4nnK4zXsJ+IJ1tu01+Wxsk
	ElXXoVsYJm8zTg9WtARYvk5Jyqnb8NrWrhovT0szHDPyOr7OSX2OdBY/dgzOjRA==
X-Google-Smtp-Source: AGHT+IETqzUpawg885/kB80keFks80OiJhCCtToTetppLAPr7SD5wI4k21XhpSWzTxnkyn8KcfkmsftsZahe3kq3yHo=
X-Received: by 2002:a05:690c:360e:b0:6ef:6d61:c254 with SMTP id
 00721157ae682-6efad2f794fmr45025087b3.38.1733242509383; Tue, 03 Dec 2024
 08:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Preston <preston@yourpreston.com>
Date: Tue, 3 Dec 2024 11:14:58 -0500
Message-ID: <CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>
Subject: ethernet over l2tp with vlan
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello folks, please let me know if there=E2=80=99s a more appropriate place=
 to
ask this but I believe I=E2=80=99ve found something that isn=E2=80=99t supp=
orted in
iproute2 and would like to ask your thoughts.

I am trying to encapsulate vlan tagged ethernet traffic inside of an
l2tp tunnel.This is something that is actively used in controllerless
wifi aggregation in large networks alongside Ethernet over GRE. There
are draft RFCs that cover it as well. The iproute2 documentation I=E2=80=99=
ve
found on this makes it seem that it should work but isn=E2=80=99t explicit.

Using a freshly compiled iproute2 (on Rocky 8) I am able to make this
work with GRE without issue. L2tp on the other hand seems to quietly
drop the vlan header. I=E2=80=99ve tried doing the same with a bridge type
setup and still see the same behavior. I've been unsuccessful in
debugging it further, I don=E2=80=99t think the debug flags in iproute2's
ipl2tp.c are functional and I suppose the issue might instead be in
the kernel module which isn=E2=80=99t something I=E2=80=99ve tried debuggin=
g before.
Is this a bug? Since plain ethernet over l2tp works I assumed vlan
support as well.


# Not Working L2TP:
[root@iperf1 ~]# ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap
udp local 2.2.2.2 remote 1.1.1.1 udp_sport 1701 udp_dport 1701
[root@iperf1 ~]# ip l2tp add session tunnel_id 1 session_id 1 peer_session_=
id 1
[root@iperf1 ~]# ip link add link l2tpeth0 name l2tpeth0.1319 type vlan id =
1319
[root@iperf1 ~]# ip link set l2tpeth0 up
[root@iperf1 ~]# ip link set l2tpeth0.1319 up
Results: (captured at physical interface, change wireshark decoding
l2tp value 0 if checking yourself)
VLAN header dropped
Wireshark screenshot: https://i.ibb.co/stMsRG0/l2tpwireshark.png


# Working GRE:
[root@iperf1 ~]# ip link add name gre1 type gretap remote 1.1.1.1
[root@iperf1 ~]# ip link add name gre1.120 link gre1 type vlan proto
802.1q id 120
[root@iperf1 ~]# ip link set gre1 up
[root@iperf1 ~]# ip link set gre1.120 up
Results:
VLAN header present
Wireshark screenshot: https://i.ibb.co/6rJWjg9/grewireshark.png


-------------------------------------------------------
~Preston Taylor

