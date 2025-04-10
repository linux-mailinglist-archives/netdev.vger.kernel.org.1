Return-Path: <netdev+bounces-181108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735F7A83AD1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ED616BBE4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807B210F49;
	Thu, 10 Apr 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="VXLVB0nO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776C20E318;
	Thu, 10 Apr 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269500; cv=none; b=KNjDNjgZ5zCAku9RcWCTCp8tnNhCUl8Xu52tf2eqRZ7ui230p88nLB7Azb+wRl6f/Wo0ockx0F6q5sYYOLq/tSWRSLPOWmZ3043dh6AafOLVaQn/huUROd9Ryif2PFFQ7VwMhjIB2kAYqZwUO5LBoh2pSS6pnkdjgxa9kftC8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269500; c=relaxed/simple;
	bh=mbXSmKdij6xo9gTLepW2thrfrVVNI6g7LQ1n0yUoOjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUrFf+bk7ksaSURaB5bDSUEzAxJSzLFj8r9bBenvteSYwvgTgigatkzRsnSxZsArlPFwe/t3D/nhD5OCAUAQjGc8583S7XJRAPsDt8JPM7PdVBZSuEPqVd5knFBrZkxvuc5eQnBTPxnIGUzaYmWG0fC+Zk+XtIJy/iic0MiCd0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=VXLVB0nO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269482; x=1744874282; i=ps.report@gmx.net;
	bh=mbXSmKdij6xo9gTLepW2thrfrVVNI6g7LQ1n0yUoOjE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VXLVB0nO+bPR6r1oOmuePHmdc9pvmVLZWygOZORGWe6ks1ENDtrmxvMWxv8wZvaL
	 9nyjePn1GBI+u4Ol9HEPtVrQFTPsWFfaEVR98/H79reoJRev32pyAryF1rmL8g0vy
	 4jY2CCZqG+o3i7ekZylQYDraqo8ilJOtGvm/9EH2hIU2OTWXbXHkY2OH+Gzm0HQCG
	 JqQUWNk354o3+VjoN6foteq49Z1TMsq+p6lStFkiaq/KR+rkyd4tAE2GG1G60nwXJ
	 5mkZnwI1TrWoKN0M2FaLe/wX+PBXy+la8l85W41fIMmETYFEExxBO0/u8SAhhFMwy
	 U9btFSFjsolwUPibBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1tjBvB2eiF-00JfJ7; Thu, 10
 Apr 2025 09:18:02 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 05/11] net: pktgen: fix code style (WARNING: suspect code indent for conditional statements)
Date: Thu, 10 Apr 2025 09:17:42 +0200
Message-ID: <20250410071749.30505-6-ps.report@gmx.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410071749.30505-1-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:U2T/Q+vxsK93QE4PWYgVnwbtIqTI9LpoTAQPldjlb8ZwFaXTzbm
 G018huIj7ob85oMnhvSAxvmpc5zNgWyoCn6EZGx0fe7/7u6q5gtUwtafKiHLLe7wPVhgXl7
 /1BuU3g5NnpDqtCB1v+cWi6KUeHD+ylDMm/at9atvgtLP9Sj+ucT2/Akbkkkks2/qYgaIqF
 IGT7oP4UOqZbVJuAw1Xpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0kr4ffX+fj0=;uvFbSt+R//l+gDUmQV4+qr2Qc/F
 jIWgBvvvX++eqyxyLSgkGzZNlKsSWxPO6TnNLNPn7V5ymNEJ6CWeBUkVHDBZqV2MtBOhid+Wr
 R+GLNfQRPPtSDgPUSrXgdt0JlWASBbr/HEiz5udcmXjBgNiz9X5+qv7VXFRdB5YUKZIMvp7xM
 dERgNqsYe99IcFjNtd1UO2jCQDGnrCtXC8ktYvXlgH3JVMQF55WZVB5XlKW19Bof7CzAbHijk
 tXe65oiwEa2q7tqmqbFRAUCG8DJLAfTaOrC34d7CNACuGqnzneLl8YsftfLGMRDnsaBJIMJFH
 t1t4dVaqIXX2vMWE2aS3crTZEPpHl4DiBPK82fKwpXjAon3SiNiLW0TfoeufUdfxz899yFxxF
 ctbLladWT59ZyjaP83KaHYOcXKQyoAGL+MhPjOXNX2g5nqJv2+PFD1d6pmW0SW9U2YAmtO2/9
 gGSboXHHVp+5ax8C7zqLlX/0AnJreh41emrj2SfPJdLpjmIEqP848IkPuyfqbvEuuYd+pfDoO
 q/bUwGQDIjm9r+MD/ZxRKCNI+TJehYTZvbljeKst6XeAKhSGGiZKPiRuf+h9/1c3ZWVUzLYZJ
 4AHCn9teDCN9MeDwfCXqas1tLLn5ke20CUAUUhsgNc+rIrVcD4xE5f4LbI4Ojivvs8RjDJUpi
 VW/v0ggQrOdLe3E0rbPNhfZqr8e6C/N/bzNqd3TDViwb7oQFGDoUV8BMb4x3Axbza4cx3j70W
 w6e2ukvx7aeAo2vHaAvTfiYqCV1zNpgU+71RVyQ5ZvEa1hDCu8OitVWB2dJsLHDkupV35LSKm
 KMPXFvVJ495A4IlHBD5NQgsz7lCHKQlEVMGAfXkgNQT/0r8yiUpcvrhkpTzwis4pTmIHhgjdE
 vDykjM6nfw+GpMj2kqhvXLuJZEMMW18vhjpZTjD0fs8pNJvYc3AUf90ijf8RHI/CVWdXVgYy/
 nWHMB+z6qWvCOshJ+EYUGy6m/Yp7F1KEG3bFMJ9pSuP/cw8Fve7hOJlvdaUhEsXJ9mIoAoURF
 /EYe8o6qEgl53cwWwNOOI7Ab6d9E66vg3G1GWjiPLp6yiPC3X+rJ6Qv/EHLmTh2GrBLlCRQtJ
 xis/sEfSzT8kb3feeXsLZHrb644sxUswj9t+ap2SyZQKbvGDfY8TTNcTR1kgCmYCQf+pYsbGR
 l6t+MWOJu88f7zD+Y60x/NWMNAu5h3xG95hMzJfp6g0DFlz3hoLmRyXL9U7bmYVgzxomXgeG4
 gF+An9KTmmHxCBm4fQN43qneARjbFR75nWsIQla8dYMUGJZ07Q8VibIeK9YdMeaEstRp8ajrh
 SNCmxk82Bbqj9cJ2J19bxsi2is+fkeOdwSXN0nFkKd7EySlVE2n5IVVvM2d4IcoTFW6TY7/Io
 FsIShePKeJqVvgGlnaOqoRy0pNsSvDFWjdLJU8JlaNkYLI8BP49YXraYFMgL3J2EHvjOFzwWR
 BIU614SNHCvDOirifC2L4I4a0IZCppDLwU6H77awHwMIdoxfb

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSB3YXJuaW5nczoKCiAgV0FSTklORzogc3VzcGVjdCBj
b2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cyAoOCwgMTcpCiAgIzI5MDE6IEZJ
TEU6IG5ldC9jb3JlL3BrdGdlbi5jOjI5MDE6CiAgKyAgICAgICB9IGVsc2UgewogICsgICAgICAg
ICAgICAgICAgc2tiID0gX19uZXRkZXZfYWxsb2Nfc2tiKGRldiwgc2l6ZSwgR0ZQX05PV0FJVCk7
CgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQog
bmV0L2NvcmUvcGt0Z2VuLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3Jl
L3BrdGdlbi5jCmluZGV4IDc2NmM0YTE1MTVmNC4uYzdjYWFmNjhmZmVlIDEwMDY0NAotLS0gYS9u
ZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtMjg5OSw3ICsyODk5
LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpwa3RnZW5fYWxsb2Nfc2tiKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYsCiAJCQlza2ItPmRldiA9IGRldjsKIAkJfQogCX0gZWxzZSB7Ci0JCSBza2Ig
PSBfX25ldGRldl9hbGxvY19za2IoZGV2LCBzaXplLCBHRlBfTk9XQUlUKTsKKwkJc2tiID0gX19u
ZXRkZXZfYWxsb2Nfc2tiKGRldiwgc2l6ZSwgR0ZQX05PV0FJVCk7CiAJfQogCiAJLyogdGhlIGNh
bGxlciBwcmUtZmV0Y2hlcyBmcm9tIHNrYi0+ZGF0YSBhbmQgcmVzZXJ2ZXMgZm9yIHRoZSBtYWMg
aGRyICovCi0tIAoyLjQ5LjAKCg==

