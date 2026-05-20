Return-Path: <netdev+bounces-289980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLgcLRrSDWpP3gUAu9opvQ
	(envelope-from <netdev+bounces-289980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:24:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F541590BE8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81F5132EF004
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB2B3F0AB6;
	Wed, 20 May 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLNLEAH9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010E3EFFBF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289464; cv=pass; b=P9rtDxR7DnpnVvorcKBY2dBleaHfccfsnG4tmIs6FWb2QfO30+L1KzK3R3SDvcwIp5+BXcFFdk79c/S9HVCtuxG21O18XZ3MpL44iQD5VS1MvjhW4L3bq2rEKt5ZG/Q1CXnkac9uI7W+IbtQM8yWEM1qsqLRC3e7kOYKnmTSLJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289464; c=relaxed/simple;
	bh=VcxAEbMEvgzmwn812LigAjE2HOFJfU3uOk6nrhuXsds=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=P+aUXH1/DAA4gVjMbDG5fo+9KiUZ/ylheS8cHKfz885XJjUIb5Qoo++tssaHvywT0ZsG5LRsLAbJz+ZfVSHxzMYn6f3MDUb4DZd9T5DYDLkXCGlQTvXRmKQpsUa1+ZasfjejtFgwR/vXEoqpwpvmsMZyCnn+PRpzqB/K+ZeuxjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLNLEAH9; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbec19732eso5828339a34.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779289461; cv=none;
        d=google.com; s=arc-20240605;
        b=WSJzdQTIbcDgHJjeRf3IzbmxY8rJxsw34ltQcQosQstRNuuPsyhx7o+Ex6sS+DISAU
         qlUm+MQyRkkcgUOgsAzlEGeqy3BqFkR79se1RNC38uXtgaDXn0GAzttdRSvpU6Iv8goN
         2sTG7u3wUXuvGxz57X7IgEw4LgM76kkj1FFI1ZnfAawR7xfzvZGPhLmBscFUZXi0bMPX
         zSB6GFsiue5Oejk2dVinM6dl4NPMd0cBcoeIcrYeS7i6e5hWvpbxt0mZwYKXQSUM8gMV
         RSyJ/DDu66GzyTkuJK2e2h5VPGIiTe9DnKCfPQYEbUCa2h8Sk3+PJMzHPS0/5XjWoQqq
         6yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VcxAEbMEvgzmwn812LigAjE2HOFJfU3uOk6nrhuXsds=;
        fh=xU2mSmrcPP5bXR2/o8yLTFJ7UU2+lDg5iNnNqwX1yMA=;
        b=DlqHcKihEUmwB+MSecFBPqE/tC61p3ysetSjaRkPKKr2G6AR7n3b1a4ZQIHzclqfiq
         sbM7Dc/3/qq3siZ32TGKKXbZKiBuGwVIb1sDwobDnV7q9LC//PuzAgF5gRnHPR2Uv9tO
         Mj+5I2MCdzdf9aEIOYJakNQpzY4qrnAuYaHZ8XIGWkOTn2hFcGUXE+98YcwRaleQA5u0
         MmUr8XeArxJNav/Xw4PZNNBUYbnml3zSxS0v5F3+4OYGANq3eVP1cPcRmYmdQDnPVl3R
         xTsRxROivGTdTidmw+BSK+QFUe/YQGy4eM5pzZxYNsLgrb69cH87Mm4IgnK/7slSr0Yk
         IkVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779289461; x=1779894261; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VcxAEbMEvgzmwn812LigAjE2HOFJfU3uOk6nrhuXsds=;
        b=RLNLEAH9a+vUNJOaJS6kVbBLVgV1e8HOwAKj908eeiaPnLKS5i7VJzQigmS8ovjYNH
         ibeBp6F8J+Yg1km1CpQ6FBb/duyRldAic4P5qvy9YuwcibK+49sFP7fO8E6zHvUWxLVu
         zw2Jf5oVQZ2mrpw7QCAocT9FSCYwlMm4I0kbfIFuLFGNw/ublzdfdeWLjpySCRpBk/Jp
         zrBFwYmQWi+HViT2Bj/Xcs+Y48gTmVqoqV0s6GYbP70kOvlRBBoF5Mf37eJTAmjuonKv
         Ej4TxoSrYgxAzOC3K0B6d52KYTHAxzAKARBCYK7tBIkMkj7uy0k4hP3uklNc0n5N8Gv0
         ECug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289461; x=1779894261;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcxAEbMEvgzmwn812LigAjE2HOFJfU3uOk6nrhuXsds=;
        b=nEv9uSyQFO2jrT1hen1irdHT5FVBEM2Pm0d1aDguBRSH/eryjrb0JsMzJea0TR3Y65
         BaSJQqzai0SsyeNjfKzlvEym5D1LxPOLDQpo0GGAPTnme6mIriTBA/cbN1LCGlXhjG1d
         XutwH+/duFfSCBH/eiajnugW4G+Qz0T0YJhn1fXSdC8JJtjBsHubewhfUNSCJxngQmC/
         RcTjs2xougBzo/tNsOhVMzIBcydXeHNjclo1oEutnElhBmU3zFve6cXOrb9MYbpPVC2a
         2Z9TzbTy+GuJzWEeTiNEfLhS+uj1pHKXfryLSCF12GFOKbbM1Xg46ksNFxy7cLDUP8u7
         /t/g==
X-Gm-Message-State: AOJu0YxqLXnXb1yULxYzUdsTglMxYPgDsgdd0H/loHJXSEnKqu4+U6Sm
	v739JmquyfCOZKgBFcaeA5qpiQ0PJS27WYnVgXQ/YNI1dxpvPfcz6Z4RhRAbGEaYSNS+Npt5dXG
	lEkn8boYB/CKTxU5980Kot6HwDtnik+V8plGM
X-Gm-Gg: Acq92OGdwoLMvfnssiJuHZCnO8jlESNi0TWROITZs/OTPPRSxra7lhwfi/HiXb/dEQA
	4HpCIIJLu7WRpy4lsWN1Y6u5eF1Qi87/+f5W3xY/MiKJVXUsk7Lq+LrJpFPRTYKvwqTAorHq2RO
	Zrt2eyEHdonEtXfevQM19nO41XNEpNFvNEwUs1OVTySfV6xGii0w4nMZAdk35nBWZG6c/bdAYqC
	TcUog3RXEhA1mHKq5JzSkBmdo799hQCDAeF2VoeA1z4RxvOscdEFwz7VmXKf1CvMgpIF8UXCUxp
	ev+Z6kQT9CQJ+dg7X7JBKmGEgcUior3AMssViQ==
X-Received: by 2002:a05:6808:4f10:b0:46a:c98c:bfe9 with SMTP id
 5614622812f47-482e59301c7mr16481079b6e.40.1779289461031; Wed, 20 May 2026
 08:04:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 20 May 2026 10:04:20 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 20 May 2026 08:03:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JUNYI LIU <moss80199@gmail.com>
Date: Wed, 20 May 2026 10:04:20 -0500
X-Gm-Features: AVHnY4IcFbPKOjiFC7i_vTY9oistAuyVL8Yy6JCCR4kbhjtNNoz4E9En-tjWEOg
Message-ID: <CADxpCqCB8jDSybr11TkudjUL8qWqJDDxd6zDAgR_Ewqoc7M7EQ@mail.gmail.com>
Subject: Possible devmem TCP TX dma-buf binding id authorization issue
To: netdev@vger.kernel.org, almasrymina@google.com, sdf@fomichev.me, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Content-Type: multipart/mixed; boundary="0000000000004799e90652411ca0"
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-diff];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moss80199@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F541590BE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000004799e90652411ca0
Content-Type: multipart/alternative; boundary="0000000000004799e70652411c9e"

--0000000000004799e70652411c9e
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a possible authorization issue in the Linux devmem TCP TX
path.
This report was prepared with AI assistance and is being routed
public/subsystem-first rather than as a security-only private report.

Main issue: after a dma-buf is bound for devmem TCP TX, later
SCM_DEVMEM_DMABUF send use appears to accept the global binding id without
checking that the sender created the binding, still has the original
dma-buf fd,
or has explicit delegation.

Conservative impact: on systems where devmem TCP TX is usable, a local
process
that has learned or been supplied an active binding id may be able to make
the
kernel/NIC transmit bytes from a dma-buf bound by another process through
the same
netdev. I am not claiming RCE, privilege escalation, arbitrary kernel memory
read, a bind-rx bypass, or practical brute-force discovery of active ids.

Tested tree: Linux master commit 6916d5703ddf9a38f1f6c2cc793381a24ee914c6.
Introducing commit: bd61848900bf, net: devmem: Implement TX path.

The full report is attached as report.txt. I also attached a candidate fix
diff
as a discussion patch. It passed git apply check on the tested tree. I have
source-level evidence and a small local model, but no current-run live
two-process replay because that requires a netmem TX-capable kernel/device
setup.

I can provide the small harness or patch-form regression material if you
would
like it; I kept additional repro material out of this message to keep the
thread concise.

Regards,
JUNYI LIU

--0000000000004799e70652411c9e
Content-Type: text/html; charset="UTF-8"

<p>Hello,</p>
<p>I am reporting a possible authorization issue in the Linux devmem TCP TX path.<br>
This report was prepared with AI assistance and is being routed<br>
public/subsystem-first rather than as a security-only private report.</p>
<p>Main issue: after a dma-buf is bound for devmem TCP TX, later<br>
SCM_DEVMEM_DMABUF send use appears to accept the global binding id without<br>
checking that the sender created the binding, still has the original dma-buf fd,<br>
or has explicit delegation.</p>
<p>Conservative impact: on systems where devmem TCP TX is usable, a local process<br>
that has learned or been supplied an active binding id may be able to make the<br>
kernel/NIC transmit bytes from a dma-buf bound by another process through the same<br>
netdev. I am not claiming RCE, privilege escalation, arbitrary kernel memory<br>
read, a bind-rx bypass, or practical brute-force discovery of active ids.</p>
<p>Tested tree: Linux master commit 6916d5703ddf9a38f1f6c2cc793381a24ee914c6.<br>
Introducing commit: bd61848900bf, net: devmem: Implement TX path.</p>
<p>The full report is attached as report.txt. I also attached a candidate fix diff<br>
as a discussion patch. It passed git apply check on the tested tree. I have<br>
source-level evidence and a small local model, but no current-run live<br>
two-process replay because that requires a netmem TX-capable kernel/device<br>
setup.</p>
<p>I can provide the small harness or patch-form regression material if you would<br>
like it; I kept additional repro material out of this message to keep the<br>
thread concise.</p>
<p>Regards,<br>
JUNYI LIU</p>

--0000000000004799e70652411c9e--
--0000000000004799e90652411ca0
Content-Type: text/plain; charset="US-ASCII"; name="report.txt"
Content-Disposition: attachment; filename="report.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9ee6cde42f0897e7_0.1

U3ViamVjdDogUG9zc2libGUgZGV2bWVtIFRDUCBUWCBkbWEtYnVmIGJpbmRpbmcgaWQgYXV0aG9y
aXphdGlvbiBpc3N1ZQoKUmVwb3J0ZXI6IEpVTllJIExJVQoKQUktYXNzaXN0ZWQgY2xhc3NpZmlj
YXRpb246IFRoaXMgcmVwb3J0IHdhcyBwcmVwYXJlZCB3aXRoIEFJIGFzc2lzdGFuY2UgYW5kIGlz
CmJlaW5nIHRyZWF0ZWQgYXMgcHVibGljL3RyaXZpYWwtdG8tZGlzY292ZXIgcm91dGluZyBtYXRl
cmlhbC4gUmVwcm9kdWNlcgptYXRlcmlhbCBpcyBhdmFpbGFibGUgb24gbWFpbnRhaW5lciByZXF1
ZXN0IHJhdGhlciB0aGFuIGluY2x1ZGVkIGlubGluZS4KCkFmZmVjdGVkIGFyZWE6IG5ldC9jb3Jl
L2Rldm1lbS5jLCBuZXQvY29yZS9uZXRkZXYtZ2VubC5jLCBuZXQvY29yZS9zb2NrLmMsCm5ldC9j
b3JlL2RhdGFncmFtLmMsIG5ldC9pcHY0L3RjcC5jCgpUZXN0ZWQgdHJlZTogTGludXggbWFzdGVy
IGNvbW1pdCA2OTE2ZDU3MDNkZGY5YTM4ZjFmNmMyY2M3OTMzODFhMjRlZTkxNGM2CgpBZmZlY3Rl
ZCB2ZXJzaW9uIHJhbmdlOiBvYnNlcnZlZCBmcm9tIHRoZSBpbnRyb2R1Y2luZyBjb21taXQgdGhy
b3VnaCB0aGUgdGVzdGVkCm1hc3RlciBjb21taXQuIExvY2FsIHRhZ3MgY29udGFpbmluZyB0aGUg
aW50cm9kdWNpbmcgY29tbWl0IGluY2x1ZGUgdjYuMTYtcmMxCmFuZCBsYXRlci4KCkludHJvZHVj
aW5nIGNvbW1pdDogYmQ2MTg0ODkwMGJmICgibmV0OiBkZXZtZW06IEltcGxlbWVudCBUWCBwYXRo
IikKClByb2JsZW06CgpTdW1tYXJ5OgoKVGhlIGRldm1lbSBUQ1AgVFggcGF0aCBhcHBlYXJzIHRv
IHRyZWF0IHRoZSByZXR1cm5lZCBkbWEtYnVmIGJpbmRpbmcgaWQgYXMgYQpnbG9iYWwgbG9va3Vw
IGtleSByYXRoZXIgdGhhbiBjaGVja2luZyB0aGF0IHRoZSBzZW5kZXIgb3ducyB0aGUgYmluZGlu
ZyBvciBzdGlsbApwb3NzZXNzZXMgdGhlIG9yaWdpbmFsIGRtYS1idWYgZmQuCgpJIHVuZGVyc3Rh
bmQgdGhhdCB0aGUgVFggYmluZCBvcGVyYXRpb24gaXRzZWxmIG1heSBpbnRlbnRpb25hbGx5IGJl
IGxlc3MKcHJpdmlsZWdlZCB0aGFuIHRoZSBSWCBiaW5kIG9wZXJhdGlvbi4gVGhlIGNvbmNlcm4g
aW4gdGhpcyByZXBvcnQgaXMgbmFycm93ZXI6CmFmdGVyIGEgVFggYmluZGluZyBleGlzdHMsIGxh
dGVyIFRDUCBzZW5kIHVzZSBvZiB0aGUgZ2xvYmFsIGlkIGRvZXMgbm90IGFwcGVhcgp0byB2ZXJp
ZnkgY3JlYXRvciwgZmQgcG9zc2Vzc2lvbiwgb3IgYW4gZXhwbGljaXQgZGVsZWdhdGlvbiByZWxh
dGlvbnNoaXAuCgpBZnRlciBvbmUgcHJvY2VzcyBiaW5kcyBhIGRtYS1idWYgZm9yIFRYIHRocm91
Z2ggTkVUREVWX0NNRF9CSU5EX1RYLCBhbm90aGVyCmxvY2FsIHByb2Nlc3MgY2FuIHB1dCB0aGUg
YmluZGluZyBpZCBpbiBTQ01fREVWTUVNX0RNQUJVRi4gVGhlIHNlbmQgcGF0aCB0aGVuCmxvb2tz
IHVwIHRoZSBnbG9iYWwgYmluZGluZyBpZCwgY2hlY2tzIHRoYXQgdGhlIGJpbmRpbmcgaXMgYSBU
WCBiaW5kaW5nIGFuZAp0aGF0IHRoZSBzb2NrZXQgcm91dGUgZGV2aWNlIG1hdGNoZXMgdGhlIGJp
bmRpbmcgZGV2aWNlLCBhbmQgdXNlcyB0aGUgc2VsZWN0ZWQKYmluZGluZyB0byBmaWxsIHNrYiBm
cmFnbWVudHMgZnJvbSBvZmZzZXRzIHN1cHBsaWVkIGJ5IHRoZSBzZW5kZXIuCgpJIGRpZCBub3Qg
ZmluZCBhIGNoZWNrIHRoYXQgdGhlIHNlbmRtc2cgY2FsbGVyIGlzIHRoZSBwcm9jZXNzIHRoYXQg
Y3JlYXRlZCB0aGUKYmluZGluZywgaGFzIGFjY2VzcyB0byB0aGUgbmV0bGluayBzb2NrZXQgdGhh
dCBlc3RhYmxpc2hlZCB0aGUgYmluZGluZywgb3IKc3RpbGwgcG9zc2Vzc2VzIHRoZSBvcmlnaW5h
bCBkbWEtYnVmIGZkLgoKUmVsZXZhbnQgcGF0aDoKCjEuIE5FVERFVl9DTURfQklORF9UWCBpcyBn
ZW5lcmF0ZWQgd2l0aG91dCBHRU5MX0FETUlOX1BFUk0uIEl0IGFjY2VwdHMgYW4KICAgaWZpbmRl
eCBhbmQgZG1hLWJ1ZiBmZC4KMi4gbmV0ZGV2X25sX2JpbmRfdHhfZG9pdCgpIGNhbGxzIG5ldF9k
ZXZtZW1fYmluZF9kbWFidWYoLi4uLCBETUFfVE9fREVWSUNFLAogICAuLi4pIGFuZCByZXR1cm5z
IGJpbmRpbmctPmlkLgozLiBuZXRfZGV2bWVtX2JpbmRfZG1hYnVmKCkgc3RvcmVzIHRoZSBhY3Rp
dmUgYmluZGluZyBpbiB0aGUgZ2xvYmFsCiAgIG5ldF9kZXZtZW1fZG1hYnVmX2JpbmRpbmdzIHhh
cnJheSB3aXRoIGEgY3ljbGljIDMyLWJpdCBpZC4KNC4gX19zb2NrX2Ntc2dfc2VuZCgpIGFjY2Vw
dHMgU0NNX0RFVk1FTV9ETUFCVUYgYnkgY29weWluZyBhIDMyLWJpdCBpZCBpbnRvCiAgIHNvY2tj
bV9jb29raWUuCjUuIHRjcF9zZW5kbXNnX2xvY2tlZCgpIGNhbGxzIG5ldF9kZXZtZW1fZ2V0X2Jp
bmRpbmcoc2ssIHNvY2tjLmRtYWJ1Zl9pZCkuCjYuIG5ldF9kZXZtZW1fZ2V0X2JpbmRpbmcoKSBj
aGVja3MgdGhhdCB0aGUgYmluZGluZyBleGlzdHMsIGhhcyB0eF92ZWMsIGFuZAogICB0aGF0IHRo
ZSByb3V0ZSBkZXZpY2UgZXF1YWxzIGJpbmRpbmctPmRldi4gSXQgZG9lcyBub3QgY2hlY2sgYmlu
ZGluZwogICBvd25lcnNoaXAgb3IgZG1hLWJ1ZiBmZCBwb3NzZXNzaW9uLgo3LiB6ZXJvY29weV9m
aWxsX3NrYl9mcm9tX2Rldm1lbSgpIGludGVycHJldHMgaW92ZWMgYmFzZSBhZGRyZXNzZXMgYXMg
b2Zmc2V0cwogICBpbnRvIHRoZSBzZWxlY3RlZCBiaW5kaW5nIGFuZCBhcHBlbmRzIHRoZSBjb3Jy
ZXNwb25kaW5nIG5ldF9pb3YgZnJhZ21lbnRzCiAgIHRvIHRoZSBvdXRnb2luZyBza2IuCgpTZWN1
cml0eSBpbXBhY3Q6CgpPbiBhIHN5c3RlbSB3aGVyZSBkZXZtZW0gVENQIFRYIGlzIHVzYWJsZSwg
dGhpcyBsb29rcyBsaWtlIGEgbG9jYWwKY29uZmlkZW50aWFsaXR5IGlzc3VlLiBBIHByb2Nlc3Mg
dGhhdCBkb2VzIG5vdCBwb3NzZXNzIHRoZSB2aWN0aW0ncyBkbWEtYnVmIGZkCm1heSBiZSBhYmxl
IHRvIG1ha2UgdGhlIGtlcm5lbC9OSUMgdHJhbnNtaXQgYnl0ZXMgZnJvbSB0aGUgdmljdGltJ3Mg
Ym91bmQKZG1hLWJ1ZiBieSBsZWFybmluZyBvciBiZWluZyBzdXBwbGllZCB0aGUgYWN0aXZlIGJp
bmRpbmcgaWQgYW5kIHJvdXRpbmcgYSBzb2NrZXQKdGhyb3VnaCB0aGUgc2FtZSBuZXRkZXYuCgpU
aGUgc2NvcGUgaXMgbm90IGFyYml0cmFyeSBrZXJuZWwgbWVtb3J5LiBUaGUgYXBwYXJlbnQgcmVh
ZC90cmFuc21pdCBzY29wZSBpcwp0aGUgdmljdGltIGRtYS1idWYgdGhhdCB3YXMgYWxyZWFkeSBi
b3VuZCBmb3IgZGV2bWVtIFRDUCBUWC4gSSBhbSBhbHNvIG5vdApjbGFpbWluZyByZW1vdGUgZXhw
bG9pdGF0aW9uLCBSQ0UsIGEgYmluZC1yeCBieXBhc3MsIG9yIHByYWN0aWNhbCBicnV0ZS1mb3Jj
ZQpkaXNjb3Zlcnkgb2YgYWN0aXZlIGJpbmRpbmcgaWRzLgoKQ29uZGl0aW9uczoKClRoZSBpc3N1
ZSByZXF1aXJlcyBkZXZtZW0gVENQIFRYIHRvIGJlIHVzYWJsZSBvbiB0aGUgYWZmZWN0ZWQgc3lz
dGVtLCBpbmNsdWRpbmcKYSByb3V0ZS1jb21wYXRpYmxlIG5ldGRldiB3aXRoIG5ldG1lbSBUWCBz
dXBwb3J0IGFuZCBhbiBhY3RpdmUgdmljdGltIFRYCmRtYS1idWYgYmluZGluZy4gVGhlIGF0dGFj
a2VyIGlzIGxvY2FsIGFuZCBjYW4gY3JlYXRlIGEgVENQIHNvY2tldCByb3V0ZWQKdGhyb3VnaCB0
aGUgc2FtZSBuZXRkZXYuIFRoZSBjdXJyZW50IHJlcG9ydCBhc3N1bWVzIHRoZSBhdHRhY2tlciBo
YXMgbGVhcm5lZCwKcmVjZWl2ZWQsIGxvZ2dlZCwgb3Igb3RoZXJ3aXNlIG9idGFpbmVkIHRoZSBh
Y3RpdmUgYmluZGluZyBpZDsgaWQgZGlzY292ZXJ5IGFuZApwcm9iaW5nIGNvc3Qgd2VyZSBub3Qg
bWVhc3VyZWQuCgpOZWdhdGl2ZSBjb250cm9scyBvYnNlcnZlZCBpbiBzb3VyY2UvbW9kZWwgcmV2
aWV3OgoKLSBhIG1pc3NpbmcgaWQgZmFpbHMgYXQgbmV0X2Rldm1lbV9sb29rdXBfZG1hYnVmKCk7
Ci0gYSByb3V0ZSBkZXZpY2UgZGlmZmVyZW50IGZyb20gYmluZGluZy0+ZGV2IGZhaWxzIGluIG5l
dF9kZXZtZW1fZ2V0X2JpbmRpbmcoKTsKLSBiaW5kLXJ4IGlzIGFkbWluLXBlcm0gZ2F0ZWQgYW5k
IGlzIG5vdCB0aGUgZGlyZWN0IGlzc3VlOwotIGEgY2FuZGlkYXRlIG93bmVyIGNoZWNrIGJsb2Nr
cyBhIGRpZmZlcmVudCBsb2NhbCBhY3RvciB3aGlsZSBhbGxvd2luZyB0aGUKICBiaW5kZXIgdG8g
dXNlIGl0cyBvd24gaWQuCgpSZXByb2R1Y2VyIHN0YXR1czoKCkkgaGF2ZSBzb3VyY2UtbGV2ZWwg
ZXZpZGVuY2UgYW5kIGEgc21hbGwgbG9jYWwgbW9kZWwgb2YgdGhlIGFjdG9yIHNwbGl0LiBJIGhh
dmUKbm90IHJ1biBhbiBlbmQtdG8tZW5kIGxpdmUgdHdvLXByb2Nlc3Mgc2VuZC9yZWNlaXZlIHJl
cGxheSBiZWNhdXNlIHRoaXMgcmVxdWlyZXMKYSBrZXJuZWwgYW5kIGRldmljZSBzZXR1cCB3aXRo
IG5ldG1lbSBUWCBzdXBwb3J0LiBBIG1haW50YWluZXItbmF0aXZlIHJlcHJvCmNvdWxkIGJlIGJ1
aWx0IGZyb20gdGhlIGV4aXN0aW5nIG5jZGV2bWVtIHNlbGZ0ZXN0IGJ5IHNwbGl0dGluZyBUWCBp
bnRvIHR3bwphY3RvcnM6CgoxLiB2aWN0aW0gYmluZHMgYSBkbWEtYnVmIGNvbnRhaW5pbmcgYSBt
YXJrZXIgYW5kIGtlZXBzIHRoZSBZTkwgc29ja2V0IG9wZW47CjIuIGF0dGFja2VyIGRvZXMgbm90
IHJlY2VpdmUgdGhlIGRtYS1idWYgZmQgYW5kIHNlbmRzIHdpdGggU0NNX0RFVk1FTV9ETUFCVUYK
ICAgdXNpbmcgdGhlIHZpY3RpbSBiaW5kaW5nIGlkOwozLiByZWNlaXZlciBvYnNlcnZlcyB0aGUg
bWFya2VyIGJ5dGVzOwo0LiB3cm9uZy1pZCwgd3JvbmctZGV2aWNlLCBhbmQgcGF0Y2hlZC1vd25l
ci1jaGVjayBjb250cm9scyBmYWlsIGNsb3NlZC4KCkNhbmRpZGF0ZSBmaXggZGlyZWN0aW9uOgoK
QSBjb25zZXJ2YXRpdmUgY2FuZGlkYXRlIGZpeCBpcyBhdHRhY2hlZCBhcyBjYW5kaWRhdGVfZml4
LmRpZmYuIEl0IHJlY29yZHMgdGhlCmVmZmVjdGl2ZSB1aWQgdGhhdCBjcmVhdGVkIHRoZSBiaW5k
aW5nIGFuZCByZWplY3RzIFRYIGJpbmRpbmcgdXNlIGJ5IGEgZGlmZmVyZW50CmV1aWQgdW5sZXNz
IHRoZSBjYWxsZXIgaGFzIENBUF9ORVRfQURNSU4gaW4gdGhlIHNvY2tldCBuZXR3b3JrIG5hbWVz
cGFjZS4KClRoaXMgaXMgaW50ZW5kZWQgYXMgYSBkaXNjdXNzaW9uIHBhdGNoLCBub3QgYSBmaW5h
bCBBUEkgZGVjaXNpb24uIFVwc3RyZWFtIG1heQpwcmVmZXIgYSBzdHJpY3RlciBmZC1iYWNrZWQg
Y2FwYWJpbGl0eSBtb2RlbCwgYSBwZXItbmV0bGluay1zb2NrZXQgYXNzb2NpYXRpb24sCm9yIGFu
IGV4cGxpY2l0IGRlbGVnYXRpb24gQVBJIGlmIGNyb3NzLXByb2Nlc3MgVFggYmluZGluZyBzaGFy
aW5nIGlzIGludGVuZGVkLgoKV2h5IEkgdGhpbmsgdGhpcyBpcyBhIHNlY3VyaXR5IGJvdW5kYXJ5
OgoKVGhlIGRtYS1idWYgZmQgaXMgdGhlIG9iamVjdCBjYXBhYmlsaXR5IGZvciBhY2Nlc3MgdG8g
dGhlIHVuZGVybHlpbmcgbWVtb3J5LgpUaGUgZGV2bWVtIFRYIGRvY3VtZW50YXRpb24gZGVzY3Jp
YmVzIE5FVERFVl9DTURfQklORF9UWCBhcyByZXR1cm5pbmcgYQpkbWEtYnVmIGlkIGZvciB0aGUg
Ym91bmQgZG1hLWJ1ZiwgYW5kIHRoZSBiaW5kaW5nIGxpZmV0aW1lIGlzIHRpZWQgdG8gY2xvc2lu
Zwp0aGUgbmV0bGluayBzb2NrZXQgdGhhdCBlc3RhYmxpc2hlZCB0aGUgYmluZGluZy4gVGhlIGlt
cGxlbWVudGF0aW9uIGFsc28ga2VlcHMKYSBwZXItbmV0bGluay1zb2NrZXQgYmluZGluZyBsaXN0
IGZvciBjbGVhbnVwLiBUaGF0IG1vZGVsIGRvZXMgbm90IGxvb2sKY29uc2lzdGVudCB3aXRoIGFu
eSB1bnJlbGF0ZWQgcHJvY2VzcyBiZWluZyBhYmxlIHRvIHVzZSBhIHNtYWxsIGdsb2JhbCBpbnRl
Z2VyCmlkLCBvbmNlIGxlYXJuZWQgb3Igc3VwcGxpZWQsIGFzIGEgYmVhcmVyIGNhcGFiaWxpdHkg
Zm9yIHRyYW5zbWl0dGluZyBmcm9tIHRoZQpib3VuZCBtZW1vcnkuCgpOb24tY2xhaW1zOgoKLSBu
byBhcmJpdHJhcnkga2VybmVsIG1lbW9yeSByZWFkOwotIG5vIHJlbW90ZSBleHBsb2l0OwotIG5v
IGNvZGUgZXhlY3V0aW9uOwotIG5vIHByaXZpbGVnZSBlc2NhbGF0aW9uIHByb3ZlbjsKLSBubyBi
aW5kLXJ4IGFkbWluLXBlcm0gYnlwYXNzOwotIG5vIGNsYWltIHRoYXQgYWN0aXZlIGlkIGd1ZXNz
aW5nIG9yIGJydXRlLWZvcmNlIHByb2JpbmcgaXMgcHJhY3RpY2FsOwotIG5vIGNsYWltIHRoYXQg
dGhlIGF0dGFjaGVkIGZpeCBpcyB0aGUgZmluYWwgdXBzdHJlYW0gZGVzaWduLgo=
--0000000000004799e90652411ca0
Content-Type: text/x-diff; charset="US-ASCII"; name="candidate_fix.diff"
Content-Disposition: attachment; filename="candidate_fix.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9ee6cde42f0897e7_0.2

RnJvbSA4NWI3YTU4Y2UwOTVlZDk3ZTdhMWRhYzVjMTI2OGUxMWVmMzlmOGNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKVU5ZSSBMSVUgPG1vc3M4MDE5OUBnbWFpbC5jb20+CkRhdGU6
IFdlZCwgMjAgTWF5IDIwMjYgMjI6Mzc6MTEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBuZXQ6IGRl
dm1lbTogcmVzdHJpY3QgVFggZG1hYnVmIGJpbmRpbmdzIHRvIGNyZWF0b3IKClRoZSBkZXZtZW0g
VENQIFRYIHBhdGggbGV0cyBzZW5kbXNnIHNlbGVjdCBhIGJvdW5kIGRtYS1idWYgYnkgdGhlCmds
b2JhbCBiaW5kaW5nIGlkIHBhc3NlZCBpbiBTQ01fREVWTUVNX0RNQUJVRi4gVGhlIGxvb2t1cCB2
YWxpZGF0ZXMKdGhhdCB0aGUgaWQgbmFtZXMgYSBUWCBiaW5kaW5nIGFuZCB0aGF0IHRoZSBzb2Nr
ZXQgcm91dGVzIHRocm91Z2ggdGhlCmJvdW5kIGRldmljZSwgYnV0IGl0IGRvZXMgbm90IHZlcmlm
eSB0aGF0IHRoZSBjYWxsZXIgY3JlYXRlZCB0aGUKYmluZGluZyBvciBzdGlsbCBoYXMgYWNjZXNz
IHRvIHRoZSBvcmlnaW5hbCBkbWEtYnVmIGZkLgoKUmVjb3JkIHRoZSBlZmZlY3RpdmUgdWlkIHRo
YXQgY3JlYXRlZCB0aGUgYmluZGluZyBhbmQgcmVqZWN0IFRYIHVzZSBieQphIGRpZmZlcmVudCBl
dWlkIHVubGVzcyB0aGUgY2FsbGVyIGhhcyBDQVBfTkVUX0FETUlOIGluIHRoZSBzb2NrZXQKbmV0
d29yayBuYW1lc3BhY2UuCgpGaXhlczogYmQ2MTg0ODkwMGJmICgibmV0OiBkZXZtZW06IEltcGxl
bWVudCBUWCBwYXRoIikKU2lnbmVkLW9mZi1ieTogSlVOWUkgTElVIDxtb3NzODAxOTlAZ21haWwu
Y29tPgotLS0KIG5ldC9jb3JlL2Rldm1lbS5jIHwgOCArKysrKysrKwogbmV0L2NvcmUvZGV2bWVt
LmggfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvbmV0L2NvcmUvZGV2bWVtLmMgYi9uZXQvY29yZS9kZXZtZW0uYwppbmRleCA0NjgzNDQ3Mzlk
YjI5ZTYyMzcyNmQ3NzIxNTdhZGFiNTBhZDNhZTNmLi42ZjYwZDZiYTRlNmY5ZDlhZDM0Y2ZiMjJi
NzY0NjJhOWUwZGJkZDQ2IDEwMDY0NAotLS0gYS9uZXQvY29yZS9kZXZtZW0uYworKysgYi9uZXQv
Y29yZS9kZXZtZW0uYwpAQCAtOCw2ICs4LDcgQEAKICAqLwogCiAjaW5jbHVkZSA8bGludXgvZG1h
LWJ1Zi5oPgorI2luY2x1ZGUgPGxpbnV4L2NyZWQuaD4KICNpbmNsdWRlIDxsaW51eC9nZW5hbGxv
Yy5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAjaW5jbHVkZSA8bGludXgvbmV0ZGV2aWNlLmg+
CkBAIC0yMjQsNiArMjI1LDcgQEAgbmV0X2Rldm1lbV9iaW5kX2RtYWJ1ZihzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2LAogCiAJYmluZGluZy0+ZG1hYnVmID0gZG1hYnVmOwogCWJpbmRpbmctPmRpcmVj
dGlvbiA9IGRpcmVjdGlvbjsKKwliaW5kaW5nLT5vd25lcl9ldWlkID0gY3VycmVudF9ldWlkKCk7
CiAKIAliaW5kaW5nLT5hdHRhY2htZW50ID0gZG1hX2J1Zl9hdHRhY2goYmluZGluZy0+ZG1hYnVm
LCBkbWFfZGV2KTsKIAlpZiAoSVNfRVJSKGJpbmRpbmctPmF0dGFjaG1lbnQpKSB7CkBAIC0zNzYs
NiArMzc4LDEyIEBAIHN0cnVjdCBuZXRfZGV2bWVtX2RtYWJ1Zl9iaW5kaW5nICpuZXRfZGV2bWVt
X2dldF9iaW5kaW5nKHN0cnVjdCBzb2NrICpzaywKIAkJZ290byBvdXRfZXJyOwogCX0KIAorCWlm
ICghdWlkX2VxKGN1cnJlbnRfZXVpZCgpLCBiaW5kaW5nLT5vd25lcl9ldWlkKSAmJgorCSAgICAh
bnNfY2FwYWJsZShzb2NrX25ldChzayktPnVzZXJfbnMsIENBUF9ORVRfQURNSU4pKSB7CisJCWVy
ciA9IC1FUEVSTTsKKwkJZ290byBvdXRfZXJyOworCX0KKwogCXJjdV9yZWFkX2xvY2soKTsKIAlk
c3QgPSBfX3NrX2RzdF9nZXQoc2spOwogCS8qIElmIGRzdCBpcyBOVUxMIChyb3V0ZSBleHBpcmVk
KSwgYXR0ZW1wdCB0byByZWJ1aWxkIGl0LiAqLwpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2bWVt
LmggYi9uZXQvY29yZS9kZXZtZW0uaAppbmRleCAxYzVjMTg1ODFmY2IxNDY0NTBjZmIxOGE0YjFk
MGNlOGExN2I5NmE5Li4yYTAyMjFkMmQwOWQzNmVlYjIzMjJmYzNiNjEyNTMzOTNiMzczZDk4IDEw
MDY0NAotLS0gYS9uZXQvY29yZS9kZXZtZW0uaAorKysgYi9uZXQvY29yZS9kZXZtZW0uaApAQCAt
NDgsNiArNDgsOSBAQCBzdHJ1Y3QgbmV0X2Rldm1lbV9kbWFidWZfYmluZGluZyB7CiAJICovCiAJ
c3RydWN0IGxpc3RfaGVhZCBsaXN0OwogCisJLyogRWZmZWN0aXZlIHVpZCB0aGF0IGNyZWF0ZWQg
dGhlIGJpbmRpbmcuICovCisJa3VpZF90IG93bmVyX2V1aWQ7CisKIAkvKiByeHEncyB0aGlzIGJp
bmRpbmcgaXMgYWN0aXZlIG9uLiAqLwogCXN0cnVjdCB4YXJyYXkgYm91bmRfcnhxczsKIAotLSAK
Mi41Mi4wLndpbmRvd3MuMQoK
--0000000000004799e90652411ca0--

