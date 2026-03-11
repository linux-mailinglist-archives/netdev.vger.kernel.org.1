Return-Path: <netdev+bounces-266526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFkYD3UnsWkBrgIAu9opvQ
	(envelope-from <netdev+bounces-266526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:27:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B825F3DD
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C09A302E41E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE33033EA;
	Wed, 11 Mar 2026 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YKDV2Wnm"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B22EBB84;
	Wed, 11 Mar 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216979; cv=none; b=tw/qlHFWcY5vgNALHtqjjQ97Jmzl48NgtJ/Qttn9E5RD6R7X/pS+pmErscpXUtSgit5x0PdqtcjFPqGiTg0EJusq75eXpAQ0QYiL3IjIhWwsvvsRHjbKdydY2pYbtUf4qnsI83PEFjjbBI4TmKTB4tFvpg960Tv+xyfVqQML4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216979; c=relaxed/simple;
	bh=K8MJFjvgxoN2vFb0y2A8WHuorv2Iwnc6DzqS4N4JARw=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=KeCY22QaAtLrd/QHG1uPWk63PIWK12kIa5PNqWI5BqNJb3Hr9Tc1tysVbYRVJSitqQUtOm04SJbH975YmEGr8Bo9/4Lg+MJGUdeC8b1+orKCUsof738TKHxtE7x5ojCc6Eh7bnZqHxRJPr+RcFXIt57c6qK4nHbiP5wsWjsqwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YKDV2Wnm; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=K8MJFjvgxoN2vFb0y2A8WHuorv2Iwnc6DzqS4N4JARw=; b=Y
	KDV2WnmZGwkKijMX9ddQwkQMNlDbXCL8lSjV8aI7zYu6WdOj1I/2iLU2Cjh+Fc4A
	ua1kb6wFlGCIDYHzK5DrX7jZ/NmvbT95irCGFWeOUFnx5ndvFlR23MT0DpRQK3W6
	GGaDK5yI6NHCV/N90P/yDUvbup7vL+oud8iKJ36HYo=
Received: from luckd0g$163.com ( [183.205.138.18] ) by
 ajax-webmail-wmsvr-40-127 (Coremail) ; Wed, 11 Mar 2026 16:15:25 +0800
 (CST)
Date: Wed, 11 Mar 2026 16:15:25 +0800 (CST)
From: "Jianzhou Zhao" <luckd0g@163.com>
To: kuba@kernel.org, davem@davemloft.net, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: KCSAN: data-race in e1000_clean / e1000_xmit_frame
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2cAf6auUEp4yiZbOkfmU4Rhug7UMO3uf8n24JfPJ9wjA/p2yseUUF9NmPf88CwFTuXvxiGfTNO1/ZAU5Bifrwxk3hmxm5gz3tIpjQH1wzxxw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <43b9914b.706c.19cdbf70885.Coremail.luckd0g@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fygvCgDX75qdJLFpZch2AA--.39436W
X-CM-SenderInfo: poxfyvkqj6il2tof0z/xtbC9h32gWmxJJ0zLQAA3j
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Queue-Id: D11B825F3DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266526-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luckd0g@163.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

CgpTdWJqZWN0OiBbQlVHXSBlMTAwMDogS0NTQU46IGRhdGEtcmFjZSBpbiBlMTAwMF9jbGVhbl90
eF9pcnEgLyBlMTAwMF90c28KCkRlYXIgTWFpbnRhaW5lcnMsCgpXZSBhcmUgd3JpdGluZyB0byBy
ZXBvcnQgYSBLQ1NBTi1kZXRlY3RlZCBkYXRhIHJhY2UgdnVsbmVyYWJpbGl0eSB3aXRoaW4gdGhl
IGBlMTAwMGAgbmV0d29yayBkcml2ZXIuIFRoaXMgYnVnIHdhcyBmb3VuZCBieSBvdXIgY3VzdG9t
IGZ1enppbmcgdG9vbCwgUmFjZVBpbG90LiBUaGUgcmFjZSBvY2N1cnMgd2hlbiBgZTEwMDBfdHNv
KClgIHdyaXRlcyBhIG5ldyBgbmV4dF90b193YXRjaGAgdHJhY2tpbmcgYXJyYXkgaW5kZXggZm9y
IGEgdHJhbnNtaXNzaW9uIGJ1ZmZlciB3aXRob3V0IHZvbGF0aWxlIGxvY2tpbmcsIHdoaWxlIHRo
ZSBgZTEwMDBfY2xlYW5fdHhfaXJxKClgIHN1YnJvdXRpbmUgbG9ja2xlc3NseSBldmFsdWF0ZXMg
dGhpcyBmaWVsZCBjb25jdXJyZW50bHkuIFdlIG9ic2VydmVkIHRoaXMgYnVnIG9uIHRoZSBMaW51
eCBrZXJuZWwgdmVyc2lvbiA2LjE4LjAtMDg2OTEtZzIwNjFmMThhZDc2ZS1kaXJ0eS4KCkNhbGwg
VHJhY2UgJiBDb250ZXh0Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpCVUc6IEtDU0FOOiBkYXRhLXJhY2UgaW4gZTEwMDBf
Y2xlYW4gLyBlMTAwMF94bWl0X2ZyYW1lCgp3cml0ZSB0byAweGZmZmZjOTAwMDQxNGU0OTIgb2Yg
MiBieXRlcyBieSB0YXNrIDU1MDAgb24gY3B1IDA6CiBlMTAwMF90c28gZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvZTEwMDAvZTEwMDBfbWFpbi5jOjI3NTIgW2lubGluZV0KIGUxMDAwX3htaXRf
ZnJhbWUrMHgxNGZlLzB4MmE5MCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMC9lMTAw
MF9tYWluLmM6MzIyNgogX19uZXRkZXZfc3RhcnRfeG1pdCBpbmNsdWRlL2xpbnV4L25ldGRldmlj
ZS5oOjUyNzMgW2lubGluZV0KIG5ldGRldl9zdGFydF94bWl0IGluY2x1ZGUvbGludXgvbmV0ZGV2
aWNlLmg6NTI4MiBbaW5saW5lXQogeG1pdF9vbmUgbmV0L2NvcmUvZGV2LmM6Mzg1MyBbaW5saW5l
XQogZGV2X2hhcmRfc3RhcnRfeG1pdCsweGVlLzB4M2EwIG5ldC9jb3JlL2Rldi5jOjM4NjkKIC4u
LgogdGNwX3dyaXRlX3htaXQrMHhmNjQvMHgzZWUwIG5ldC9pcHY0L3RjcF9vdXRwdXQuYzozMDAy
CiB0Y3BfcHVzaF9vbmUrMHg4Ny8weGEwIG5ldC9pcHY0L3RjcF9vdXRwdXQuYzozMTk5CiAKcmVh
ZCB0byAweGZmZmZjOTAwMDQxNGU0OTIgb2YgMiBieXRlcyBieSBpbnRlcnJ1cHQgb24gY3B1IDE6
CiBlMTAwMF9jbGVhbl90eF9pcnEgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDAvZTEw
MDBfbWFpbi5jOjM4NzEgW2lubGluZV0KIGUxMDAwX2NsZWFuKzB4MmZiLzB4MTU3MCBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMC9lMTAwMF9tYWluLmM6MzgwNAogX19uYXBpX3BvbGwr
MHg1ZC8weDNmMCBuZXQvY29yZS9kZXYuYzo3NjY2CiBuYXBpX3BvbGwgbmV0L2NvcmUvZGV2LmM6
NzcyOSBbaW5saW5lXQogbmV0X3J4X2FjdGlvbisweDZjYy8weDg5MCBuZXQvY29yZS9kZXYuYzo3
ODgxCiBoYW5kbGVfc29mdGlycXMrMHhiZS8weDI5MCBrZXJuZWwvc29mdGlycS5jOjYyMgogLi4u
Cgp2YWx1ZSBjaGFuZ2VkOiAweDAwODMgLT4gMHgwMDhkCgpSZXBvcnRlZCBieSBLZXJuZWwgQ29u
Y3VycmVuY3kgU2FuaXRpemVyIG9uOgpDUFU6IDEgVUlEOiAwIFBJRDogMTk0ODY1IENvbW06IHN5
ei4zLjgyNzkgTm90IHRhaW50ZWQgNi4xOC4wLTA4NjkxLWcyMDYxZjE4YWQ3NmUtZGlydHkgIzQ0
IFBSRUVNUFQodm9sdW50YXJ5KSAKSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0
MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAxNAo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCkV4
ZWN1dGlvbiBGbG93ICYgQ29kZSBDb250ZXh0CkR1cmluZyBzdGFuZGFyZCBvdXRnb2luZyBuZXR3
b3JrIHRyYW5zYWN0aW9ucyBvdmVyIHRoZSBgZTEwMDBgIHF1ZXVlIGxheW91dCwgYGUxMDAwX3Rz
b2AgbWFwcyBidWZmZXIgcGFyYW1ldGVycyBpbnRvIGRlc2NyaXB0aW9ucyBhbmQgc2V0cyBgYnVm
ZmVyX2luZm8tPm5leHRfdG9fd2F0Y2hgOgpgYGBjCi8vIGRyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2UxMDAwL2UxMDAwX21haW4uYwpzdGF0aWMgaW50IGUxMDAwX3RzbyhzdHJ1Y3QgZTEwMDBf
YWRhcHRlciAqYWRhcHRlciwKCQkgICAgIHN0cnVjdCBlMTAwMF90eF9yaW5nICp0eF9yaW5nLCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCSAgICAgX19iZTE2IHByb3RvY29sKQp7CgkuLi4KCQljb250
ZXh0X2Rlc2MtPmNtZF9hbmRfbGVuZ3RoID0gY3B1X3RvX2xlMzIoY21kX2xlbmd0aCk7CgoJCWJ1
ZmZlcl9pbmZvLT50aW1lX3N0YW1wID0gamlmZmllczsKCQlidWZmZXJfaW5mby0+bmV4dF90b193
YXRjaCA9IGk7IC8vIDwtLSBDb25jdXJyZW50IDItYnl0ZSBsb2NrbGVzcyB3cml0ZQoKCQlpZiAo
KytpID09IHR4X3JpbmctPmNvdW50KQoJCQlpID0gMDsKCS4uLgp9CmBgYAoKU2ltdWx0YW5lb3Vz
bHksIGBlMTAwMF9jbGVhbl90eF9pcnEoKWAgb3BlcmF0ZXMgZnJvbSBJUlEvTkFQSSBsb29wcyB0
cmFja2luZyB0cmFpbGluZyBkZXNjcmlwdG9yIGNvbXBsZXRpb24sIGRpcmVjdGx5IHJlYWRpbmcg
YG5leHRfdG9fd2F0Y2hgIGZyb20gYWN0aXZlIGJvdW5kcyBiZWZvcmUgZXZhbHVhdGluZyB0aGUg
aGFyZHdhcmUgY29tcGxldGlvbiBtYXJrZXIgYml0OgpgYGBjCi8vIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2UxMDAwL2UxMDAwX21haW4uYwpzdGF0aWMgYm9vbCBlMTAwMF9jbGVhbl90eF9p
cnEoc3RydWN0IGUxMDAwX2FkYXB0ZXIgKmFkYXB0ZXIsCgkJCSAgICAgICBzdHJ1Y3QgZTEwMDBf
dHhfcmluZyAqdHhfcmluZykKewoJLi4uCglpID0gdHhfcmluZy0+bmV4dF90b19jbGVhbjsKCWVv
cCA9IHR4X3JpbmctPmJ1ZmZlcl9pbmZvW2ldLm5leHRfdG9fd2F0Y2g7IC8vIDwtLSBDb25jdXJy
ZW50IDItYnl0ZSBsb2NrbGVzcyByZWFkCgllb3BfZGVzYyA9IEUxMDAwX1RYX0RFU0MoKnR4X3Jp
bmcsIGVvcCk7CgoJd2hpbGUgKChlb3BfZGVzYy0+dXBwZXIuZGF0YSAmIGNwdV90b19sZTMyKEUx
MDAwX1RYRF9TVEFUX0REKSkgJiYKCS4uLgpgYGAKClJvb3QgQ2F1c2UgQW5hbHlzaXMKQSBLQ1NB
TiBkYXRhIHJhY2UgYXJpc2VzIGJlY2F1c2UgYGUxMDAwX2NsZWFuX3R4X2lycSgpYCBmZXRjaGVz
IGBuZXh0X3RvX3dhdGNoYCBiZWZvcmUgZXhhbWluaW5nIHRoZSB0cmFuc21pdCBjb21wbGV0aW9u
IHN5bmNocm9uaXphdGlvbiBgRTEwMDBfVFhEX1NUQVRfRERgIGJpdCBhc3luY2hyb25vdXNseSBh
Y3Jvc3MgaW5kZXBlbmRlbnQgY29yZSBjeWNsZXMuIFRoaXMgaW5oZXJlbnRseSBjYXVzZXMgY29s
bGlzaW9uIG92ZXJsYXBzIGFnYWluc3QgYmFja2dyb3VuZCBgZTEwMDBfeG1pdF9mcmFtZWAgY2Fs
bHMgcXVldWluZyBidWZmZXJzIG9udG8gaWRlbnRpY2FsIGFycmF5cyBkdXJpbmcgdHJhbnNtaXNz
aW9uIHBpcGVsaW5lcy4gV2hpbGUgbG9naWNhbCBzdHJ1Y3R1cmVzIGluaGVyZW50bHkgbWFzayBv
ZmYgcHJvY2Vzc2luZyBsb29wcyBpZiB0aGUgYEREYCBiaXQgZGVmYXVsdHMgbG9naWNhbGx5LCB1
bnByZWRpY3RhYmxlIGNvbXBpbGVyIGNhY2hpbmcgY2F1c2VzIHVub3B0aW1pemVkIHN0cnVjdHVy
ZSB0ZWFyaW5nLgpVbmZvcnR1bmF0ZWx5LCB3ZSB3ZXJlIHVuYWJsZSB0byBnZW5lcmF0ZSBhIHJl
cHJvZHVjZXIgZm9yIHRoaXMgYnVnLgoKUG90ZW50aWFsIEltcGFjdApUaGlzIGRhdGEgcmFjZSBw
cmVzZW50cyB0aGVvcmV0aWNhbCBsb2NhbCBtZW1vcnkgY29ycnVwdGlvbiBvciBuZXR3b3JraW5n
IHN0YXRlIGJyZWFrZG93biByaXNrcyBhbG9uZ3NpZGUgY29uc3RhbnQgS0NTQU4gcGVyZm9ybWFu
Y2UgZGVncmFkYXRpb24gaWYgYSBjb21waWxlciBpbmNvcnJlY3RseSBpbmZlcnMgdmlzaWJpbGl0
eSBhc3N1bXB0aW9ucyBhY3Jvc3MgdW5hbm5vdGF0ZWQgdmFyaWFibGVzIGJyaWRnaW5nIGhhcmR3
YXJlIHRyYW5zbWlzc2lvbiBzeW5jaHJvbml6YXRpb25zLiAKClByb3Bvc2VkIEZpeApJbXBsZW1l
bnRpbmcgYFJFQURfT05DRSgpYCBhbmQgYFdSSVRFX09OQ0UoKWAgYm91bmRzIGFyb3VuZCBgbmV4
dF90b193YXRjaGAgcmVzb2x2ZXMgdGhlIGRhdGEgcmFjZSBsb2dpY2FsbHksIGVuc3VyaW5nIGNv
cnJlY3QgbG9hZCBiYXJyaWVycyBvbiBOQVBJIGNvbnN1bWVyczoKCmBgYGRpZmYKLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDAvZTEwMDBfbWFpbi5jCisrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2UxMDAwL2UxMDAwX21haW4uYwpAQCAtMjc0OSw3ICsyNzQ5LDcg
QEAgc3RhdGljIGludCBlMTAwMF90c28oc3RydWN0IGUxMDAwX2FkYXB0ZXIgKmFkYXB0ZXIsCiAJ
CWNvbnRleHRfZGVzYy0+Y21kX2FuZF9sZW5ndGggPSBjcHVfdG9fbGUzMihjbWRfbGVuZ3RoKTsK
IAogCQlidWZmZXJfaW5mby0+dGltZV9zdGFtcCA9IGppZmZpZXM7Ci0JCWJ1ZmZlcl9pbmZvLT5u
ZXh0X3RvX3dhdGNoID0gaTsKKwkJV1JJVEVfT05DRShidWZmZXJfaW5mby0+bmV4dF90b193YXRj
aCwgaSk7CiAKIAkJaWYgKCsraSA9PSB0eF9yaW5nLT5jb3VudCkKIAkJCWkgPSAwOwpAQCAtMzgz
OSw3ICszODM5LDcgQEAgc3RhdGljIGJvb2wgZTEwMDBfY2xlYW5fdHhfaXJxKHN0cnVjdCBlMTAw
MF9hZGFwdGVyICphZGFwdGVyLAogCXVuc2lnbmVkIGludCBieXRlc19jb21wbCA9IDAsIHBrdHNf
Y29tcGwgPSAwOwogCiAJaSA9IHR4X3JpbmctPm5leHRfdG9fY2xlYW47Ci0JZW9wID0gdHhfcmlu
Zy0+YnVmZmVyX2luZm9baV0ubmV4dF90b193YXRjaDsKKwllb3AgPSBSRUFEX09OQ0UodHhfcmlu
Zy0+YnVmZmVyX2luZm9baV0ubmV4dF90b193YXRjaCk7CiAJZW9wX2Rlc2MgPSBFMTAwMF9UWF9E
RVNDKCp0eF9yaW5nLCBlb3ApOwogCiAJd2hpbGUgKChlb3BfZGVzYy0+dXBwZXIuZGF0YSAmIGNw
dV90b19sZTMyKEUxMDAwX1RYRF9TVEFUX0REKSkgJiYKYGBgCiooTm90ZTogU2ltaWxhciBgV1JJ
VEVfT05DRWAgYm91bmRzIHNob3VsZCBhbHNvIGJlIGFwcGxpZWQgdG8gYGUxMDAwX3R4X21hcGAg
YW5kIGBlMTAwMF90eF9jc3VtYCByZXNwZWN0aXZlbHkpKgoKV2Ugd291bGQgYmUgaGlnaGx5IGhv
bm9yZWQgaWYgdGhpcyBjb3VsZCBiZSBvZiBhbnkgaGVscC4KCkJlc3QgcmVnYXJkcywKUmFjZVBp
bG90IFRlYW0K

