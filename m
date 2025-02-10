Return-Path: <netdev+bounces-164821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91380A2F4B1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2891887938
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE81F4630;
	Mon, 10 Feb 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubicloud.com header.i=@ubicloud.com header.b="L03HU1Dq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547E256C6B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207328; cv=none; b=KvHSnF4iQMP+2U9DrDyruG57PA/M8rbOO50m1z02ikU6i68SQUfFwbDRYvC5nCaD8MyUcVt29Ot/6vxbYvviswOuZ+75/D7rztzQq0IfSgfoP8UQSlP8U7cRr+skqcQ9RjFQ8e+SlMpV8ht5evu9DcP4jLwn5HaHQxsYV/sA3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207328; c=relaxed/simple;
	bh=gfNXR4vSaEVJMS3lPvkBsS/dW6wB6XJO/B4mL7DHEBc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aJSvjuHJXCPEmYWGe3DVA30Rtq/qGv+k3sPiTYlBHl85Y87CpCYQwfFkH0yzRJ9QdDcHqQb7/vMlX3icssi9/K+3HJMifW2Ioyku5TbFykHAOB7uiFY4W03Qu3q/v1xkeAO5ip14i5qaRcqUaui9SkXACYhvlefwNmJm/yrJG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubicloud.com; spf=pass smtp.mailfrom=ubicloud.com; dkim=pass (2048-bit key) header.d=ubicloud.com header.i=@ubicloud.com header.b=L03HU1Dq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubicloud.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so2786357a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubicloud.com; s=google; t=1739207325; x=1739812125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvm+0EnMYRXJ/bn2uF7TNtzUtj3OtQbVGlmRFALZ31o=;
        b=L03HU1Dq130B7gkmfztpvFEMGEM2GYKlzspqgRtZ6h9kUJAuOCgioR4z8qnfV7Myq4
         kXefx/YAHt/vcdhxhbE7MYIFfjvSrxVD8KTb856tSQ/vSbgdFji1jU4zF3kzzZOiSjld
         p8+1bOdKknnHuj+p7PS1pcJZFyRS8ZDxRo93Xv+ec4aR2Tom+y3dAXnInonwrW/q34H4
         xSGKHVD0UKcvO9SzJorlnLdqht/k2UA3V/efTG771hZS20Do3m7Bi+KfNCcpesp0Qp/A
         QlYa/wb7geSKrKn7uU0P237QCW7wgGhHvIdTaaD+XD7reFUHJXLI1xW+EqExWf5gbKoC
         VAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207326; x=1739812126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvm+0EnMYRXJ/bn2uF7TNtzUtj3OtQbVGlmRFALZ31o=;
        b=U0dENSIdUoVySQO9vHjAbDwi9RmhD+Ek/1QI/09JW+vSU+2DR+iMwQpSouId8416VY
         ZzeL1Pmdc+GSJkO2mL9qk61n9GF/3I4aMXg/BTHONgO4P33G9IL7qaosE4oDEgOeC3d1
         7Ebp5dM3gdA8ORaPEjlh48J2wMTKStyipkl1Dq5TFKJBT9C9a6TRx8Nh0LOwqCNDXpW5
         obtproHLC5IruTucXiskFfxmYgUGHZ9TzA6v1+sq5wpIG7F7icoq6L+LXcKsuGQUEQhM
         FGF/KBOUor2ivtJfi9vVyRv988iPw5WMn4ENuwsA+anTOqEcZgZVGkdY7CTuuljHSF+W
         WNuQ==
X-Gm-Message-State: AOJu0Yx46LHpSuZRo0EkCQxlDKzlfSopckHeow20sVlajZXf/GMR/WML
	2YryZeDsJmixiDfhFoMwdvp91jKZ7qvdqKvaixIDvr459RPcnSqoEilWgtNs3keRys7YqeYDiQY
	uxEoqO/rK/BZkQztI+rlZbf6nHfgoGSrBHVckKLzzqi+9RQxidqI=
X-Gm-Gg: ASbGnct6RY8NG9KWiwEzrulcEvL1tyjeQf4swnTTP1/bCJFCq0tpAOBn6g/k6+kapSb
	FpB6+Wjz/xgo7x6sYZrwcHyT7hzsKufn4krI4a9lFOAGJVBzZn9FhncA8iNDA/BSLybSK8/m8TX
	QoHreyoKhX//a9MuNhEZnBHyNkkWA=
X-Google-Smtp-Source: AGHT+IHFnKiODR9wAH8CVe0A02Chu31IPUA7DY6mn6YXWqz6m/32aLIA4sWGT6uA4Q28oH+SDhHjzph7nqoUt9HELz0=
X-Received: by 2002:a17:90b:4b87:b0:2fa:e9b:33ab with SMTP id
 98e67ed59e1d1-2fa241768e3mr24563807a91.16.1739207324169; Mon, 10 Feb 2025
 09:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Furkan Sahin <furkan@ubicloud.com>
Date: Mon, 10 Feb 2025 18:08:32 +0100
X-Gm-Features: AWEUYZkUpwoZHwu9jdEz-oHmjTsBC9vYJaMYURxgFEasHcudUt9YwLnuumeUqy0
Message-ID: <CAM-1W_v_P49VKnsxUdLkXEDyVw-YHKq6YCJ-R4WSexwHuU8Ejw@mail.gmail.com>
Subject: [Performance] ip-xfrm 20x encapsulation penalty
To: netdev@vger.kernel.org
Cc: Daniel Farina <daniel@ubicloud.com>, Junhao Li <junhao@ubicloud.com>, 
	Ozgun Erdogan <ozgun@ubicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,
Respectfully, I have a question regarding the performance impact of encrypt=
ion
+ encapsulation with ip xfrm. I have a very basic setup with two namespaces=
 in
the same server. Then, we are running a very basic iperf command with and
without tunnels. The performance jump is extremely high going from encrypte=
d to
not. Here are the numbers:

Without encryption and encapsulation:
```
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# ip netns exec interface2 bash
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# iperf -s -V
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# ip netns exec interface1 bash
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# iperf -c 2a01:4f8:10a:128b:456::1
-b 100G -P 1
------------------------------------------------------------
Client connecting to 2a01:4f8:10a:128b:456::1, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  1] local 2a01:4f8:10a:128b:: port 50882 connected with
2a01:4f8:10a:128b:456::1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0116 sec  52.0 GBytes  44.6 Gbits/sec
```
With encryption and encapsulation:
```
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# ip netns exec interface2 bash
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# iperf -s -V
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# ip netns exec interface1 bash
[root@vh8m4859621y4j6xxsfgxc3wkh ~]# iperf -c
fd53:3f0e:d350:6740:456::2 -b 100G -P 1
------------------------------------------------------------
Client connecting to fd53:3f0e:d350:6740:456::2, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  1] local fd53:3f0e:d350:6740:: port 33162 connected with
fd53:3f0e:d350:6740:456::2 port 5001
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0098 sec  1.46 GBytes  1.26 Gbits/sec
```
My question is, what am I missing? Why do we see such a poor performance wi=
th
encryption + encapsulation. I didn=E2=80=99t want to provide more terminal =
output but
even with null encryption, we are seeing around 2.2 Gbit/sec. That is quite=
 a
big jump from 44.6 Gbit/sec for encapsulation. Is this expected?

Here is the very basic script I use to setup the interfaces and tunnels:
```
ip netns add interface1
ip netns add interface2
ip link add vethointerface1 addr 7a:b5:34:4e:44:be type veth peer name
vethiinterface1 addr ce:8f:66:87:d5:6f netns interface1
ip link add vethointerface2 addr 1e:e7:ef:aa:21:c0 type veth peer name
vethiinterface2 addr ba:9b:f0:50:68:cd netns interface2

ip link set dev vethointerface1 up
ip route replace 2a01:4f8:10a:128b:123::/80 via
fe80::cc8f:66ff:fe87:d56f dev vethointerface1
ip -n interface1 addr replace 2a01:4f8:10a:128b:123::1/80 dev vethiinterfac=
e1
ip -n interface1 link set dev vethiinterface1 up
ip -n interface1 route replace 2000::/3 via fe80::78b5:34ff:fe4e:44be
dev vethiinterface1

ip link set dev vethointerface2 up
ip route replace 2a01:4f8:10a:128b:456::/79 via
fe80::b89b:f0ff:fe50:68cd dev vethointerface2
ip -n interface2 addr replace 2a01:4f8:10a:128b:456::1/80 dev vethiinterfac=
e2
ip -n interface2 link set dev vethiinterface2 up
ip -n interface2 route replace 2000::/3 via fe80::1ce7:efff:feaa:21c0
dev vethiinterface2

ip -n interface1 xfrm policy add src fd53:3f0e:d350:6740:123::/79 dst
fd53:3f0e:d350:6740:456::/79 dir out tmpl src 2a01:4f8:10a:128b:123::1
dst 2a01:4f8:10a:128b:456::1 proto esp reqid 85910 mode tunnel
ip -n interface2 xfrm policy add src fd53:3f0e:d350:6740:123::/79 dst
fd53:3f0e:d350:6740:456::/79 dir in tmpl src 2a01:4f8:10a:128b:123::1
dst 2a01:4f8:10a:128b:456::1 proto esp reqid 85910 mode tunnel
ip -n interface1 xfrm policy add src fd53:3f0e:d350:6740:456::/79 dst
fd53:3f0e:d350:6740:123::/79 dir in tmpl src 2a01:4f8:10a:128b:456::1
dst 2a01:4f8:10a:128b:123::1 proto esp reqid 49480 mode tunnel
ip -n interface2 xfrm policy add src fd53:3f0e:d350:6740:456::/79 dst
fd53:3f0e:d350:6740:123::/79 dir out tmpl src 2a01:4f8:10a:128b:456::1
dst 2a01:4f8:10a:128b:123::1 proto esp reqid 49480 mode tunnel

ip -n interface1 xfrm state add src 2a01:4f8:10a:128b:123::1 dst
2a01:4f8:10a:128b:456::1 proto esp spi 0x33ff09b5 reqid 85910 mode
tunnel replay-window 0 aead 'rfc4106(gcm(aes))'
0x0efb31b0e1837b2a6f4145dc6ed81565d04654e691a063d06d1c826e001e50519e692675
128 sel src ::/0 dst ::/0
ip -n interface1 xfrm state add src 2a01:4f8:10a:128b:456::1 dst
2a01:4f8:10a:128b:123::1 proto esp spi 0x62f75b71 reqid 49480 mode
tunnel replay-window 0 aead 'rfc4106(gcm(aes))'
0xb89577cecab3a5150bc275042d1485bf917ab55fa2f3100cb135cbfc21d7ee31aa5cf5d0
128 sel src ::/0 dst ::/0
ip -n interface2 xfrm state add src 2a01:4f8:10a:128b:123::1 dst
2a01:4f8:10a:128b:456::1 proto esp spi 0x33ff09b5 reqid 85910 mode
tunnel replay-window 0 aead 'rfc4106(gcm(aes))'
0x0efb31b0e1837b2a6f4145dc6ed81565d04654e691a063d06d1c826e001e50519e692675
128 sel src ::/0 dst ::/0
ip -n interface2 xfrm state add src 2a01:4f8:10a:128b:456::1 dst
2a01:4f8:10a:128b:123::1 proto esp spi 0x62f75b71 reqid 49480 mode
tunnel replay-window 0 aead 'rfc4106(gcm(aes))'
0xb89577cecab3a5150bc275042d1485bf917ab55fa2f3100cb135cbfc21d7ee31aa5cf5d0
128 sel src ::/0 dst ::/0

ip -n interface1 addr add fd53:3f0e:d350:6740:123::2/80 dev vethiinterface1
ip -n interface2 addr add fd53:3f0e:d350:6740:456::2/80 dev vethiinterface2
ip -n interface1 route add fd53:3f0e:d350:6740:456::2/80 dev vethiinterface=
1
ip -n interface2 route add fd53:3f0e:d350:6740:123::2/80 dev vethiinterface=
2
```

Best regards,
Furkan

