Return-Path: <netdev+bounces-182733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20CEA89C87
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5341893452
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A73297A78;
	Tue, 15 Apr 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="PdpyHWnr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC4292937;
	Tue, 15 Apr 2025 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716575; cv=none; b=OoKv6aKY/moy1cC+E7ZKf0eQeXvGTqnQdiVXfZNuHjZ5jNi8ji01ijLTHR5QoOsuCGViZJ+VSvGJu+9i+Ue7ekG8c78TpoitGiP7870DiwjwIiG2/mxRMuZUOuHh/ILKFxSqFGOwmwtWcnFNtklqlWGgyueleiq++d30XDfoSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716575; c=relaxed/simple;
	bh=QVox7995iH2ZZRjtGKwDZmbEeAIvePR4xMSX9pxpVVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6K6Z5SYv7kN/fWX8AbJPD2i+yd03v4U2itJNvglVQDRdOVikAbIVrH46E0iPK0ISupWYiEaDRbOlO0XmdLOK6DKKw9C54FAgyt7DVmMuPCcws5QP4G9i6l/uqe2FhgCVbsEvqfonMeQOslvJZkxdcM/bSzigHEsMANtf2qLrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=PdpyHWnr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744716570; x=1745321370; i=ps.report@gmx.net;
	bh=QVox7995iH2ZZRjtGKwDZmbEeAIvePR4xMSX9pxpVVs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PdpyHWnrmt7Lvw5ZJd6OIVH9vsy9ADSOmOL+0EKUfVjl6AVx6Qo7bo6e6nmR/b6y
	 vqAVXyn+QWMmUEUcHd+mKjhCr91gxuEVB6SS5gfyG4GOgwYrVXzbB53oepzpWDd3P
	 4NfeFoJbdOwNFe9XPUwcm9eIGOuwOb/g2uATPKBzcZ63OYZ8XrG4B/PGy/8kCcq1m
	 lGE2fiVVRWD7zOwmaub+Ki1v+wCR66vhbeZNR8lv3DP2IxCz36xZVd0VCZovh4Fia
	 a6NO2BqgUdfpUgsCra9BZTdc6fqmETk8CSvmNRFLxg/yV3niYQWMZn9dMzmGA7LyT
	 7KlP3jcS+h+cGIA4gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1tECNv0ijh-016YIp; Tue, 15
 Apr 2025 13:29:30 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 1/3] net: pktgen: fix code style (ERROR: else should follow close brace '}')
Date: Tue, 15 Apr 2025 13:29:14 +0200
Message-ID: <20250415112916.113455-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415112916.113455-1-ps.report@gmx.net>
References: <20250415112916.113455-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:F+e5HhFJ/ntrPABsELhyF3ff0BUDT5LLYJI+pd/1o0qvb7PBMX7
 hA6n3KgTs2zfOVShinrY5IpyOQjBn8n9aG5Z+zB56XKHrpQgBwP1BMkk4I+FkWo8eV+DNgR
 ypWi54MQCCkQ4yeWXbQ8XfPVdGdS2YN6DKH4uZaMbEmwtqTW/yRdS4XBxN6HK690VwAovVO
 9jI9IGFgqvbrS9HrTDYaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MDMQgM6ygUw=;6WuY37m1U1XO4zE3SCsaXKrYBBp
 I1ujf/af5zqaQyIG++dpYgZI+eUU3/NWgbVwGRZ++Dbz4AnnlhezreotgngGLoRyN5Fx2Ni5a
 54Ya3canxhnQtYX5fzydweFqW8SyUXkAXijfPAFQh7p6xs+tVrRaDIz1s05iAQbKo+7PZLUK6
 0r+0aYNUEr7W/Jnr6naDvkAGsq4zEbDr7ejqcW+gaTGcDl/gGchA5V0pVrGgmQxDdq3ZACrlF
 vk2QlBQW+w0dXp7+6BQwlSPMpy/92uhAwzwtF06VJ7myAeGsrzcXAgPvLXtqIXzcegCRffFyS
 edWdL2Sbqu8YrHCEVDpBBJOOzrSHSo0D1iBt+ebP6aIvO2nXrKTG0MXbyLViSwAgPHn2WxGzk
 kZQ2oR9HXTUiseYjkYyqjAVkiqTo1+L27IiN8v5FRvreeOVLBL1bHnuYYIiTR0wbv1J6C/WI2
 lii/MikGPiDmn8jcKu4OmHZgfm2VW9A19rGwWH5Xe7ZkzYSo5nCEGKEO86z8/IGA2P959gk4m
 sueCCqflFMqQyUq63xYfjECYGWw3vhnj3xavmbLgUKq7NO0+o+YkGVtEGOZkz27V6UqHwzKyE
 L9BH0Kx4uaEaU+98Hr/Ici03DdDnDBoUcfAyRTcbiHMuz6ffjGG74Q9QHSx1Qn69RDTwzwgxe
 0HLa1m9ZMoO8JSOj2kQy+/W1YfYP4MW+ANTLi/FWjo7+Bh5v+IIvtTitKy9Mi7LsAj9BUr4CG
 gsgCtqkFa/H73dLzovLBuTk4WUGjsTXUUTFN2lyiBdKwIkxV7CskaDHKf9WjyosxcbiCkf2eY
 RFxEzMr71V/s+q8uE5F4Y/tQUVyIrOKvf3daRKG4wyA9Zn+dXSz1PIb+8I/1o8WIfSRTRKth5
 CBmnqZByoRUgsq2eZe1vMH8/SJPy097y0c5pSmptHpn9DA9c+6rzPx4d1yDEA7Vbn25ZqZHKC
 9geS2vIRvQcWOj/CJho/Y5zKtWdt3LB2cP0f1ZONab70epZfyMXA0G6poKtbcDmItBkkEGg91
 wIxB7kcsPZVblYBMDMuZPLfoOoHpRuPwfmkjfgjVD6F0fcDdWZiHl9AxNs8/6/StwPUIWD8Z/
 pmJ6peoguWpkXsuTMDcXfn1cssJEc9lC9Ersno3TTNlT8Xh6sc5yntKsfQYftzOmhQZ0rTZQ7
 McGgop1DqyCYHUP9shiXJtZLqn1YX28SvgLZdAgT0qrUUNJvmWbGdeLFFX7p+/NEyrQuRrw5G
 6RksgDI7uIcn7ecthU5T+ut11seAuL65sDb+dnW4Y0cVZKm1Ec5Mk94sptrfQaOmt9gm38nZY
 MHzf3uE1R6QgSAkmJz/DzaHANCiyPRO4dvUTO/c2xtKKehZrnYeZeIENLR7ZHHhSRnbkWe8Gv
 14bgfaqEyDtRcFnjNUuO2sFkg0hqqKxxErVrmDQSiK0GGmgAe2XSlz9BecW8i/1iJw45QMbG0
 wjEqCdUqHz+DkTD+fQR5VmbNcM2BeLH4FSqc/VDXjGiTLpSpC

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSBlcnJvcnM6CgogIEVSUk9SOiBlbHNlIHNob3VsZCBm
b2xsb3cgY2xvc2UgYnJhY2UgJ30nCiAgIzEzMTc6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5jOjEz
MTc6CiAgKyAgICAgICAgICAgICAgIH0KICArICAgICAgICAgICAgICAgZWxzZQoKQW5kIGNoZWNr
cGF0Y2ggZm9sbG93IHVwIGNvZGUgc3R5bGUgY2hlY2s6CgogIENIRUNLOiBVbmJhbGFuY2VkIGJy
YWNlcyBhcm91bmQgZWxzZSBzdGF0ZW1lbnQKICAjMTMxNjogRklMRTogbmV0L2NvcmUvcGt0Z2Vu
LmM6MTMxNjoKICArICAgICAgICAgICAgICAgfSBlbHNlCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBT
ZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQpDaGFuZ2VzIHYxIC0+IHYyOgogIC0gQWRk
aXRpb25hbCBhZGQgYnJhY2VzIGFyb3VuZCB0aGUgZWxzZSBzdGF0ZW1lbnQgKGFzIHN1Z2dlc3Rl
ZCBieSBhIGZvbGxvdwogICAgdXAgY2hlY2twYXRjaCBydW4gYW5kIGJ5IEpha3ViIEtpY2luc2tp
IGZyb20gY29kZSByZXZpZXcpLgotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNCArKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggZmEzMGZmMGYyNDY0
Li4yMTIwNmE1Njc4NDMgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9j
b3JlL3BrdGdlbi5jCkBAIC0xMzEzLDkgKzEzMTMsOSBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5f
aWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCQkJcHV0X3BhZ2UocGt0X2Rldi0+cGFnZSk7
CiAJCQkJcGt0X2Rldi0+cGFnZSA9IE5VTEw7CiAJCQl9Ci0JCX0KLQkJZWxzZQorCQl9IGVsc2Ug
ewogCQkJc3ByaW50ZihwZ19yZXN1bHQsICJFUlJPUjogbm9kZSBub3QgcG9zc2libGUiKTsKKwkJ
fQogCQlyZXR1cm4gY291bnQ7CiAJfQogCWlmICghc3RyY21wKG5hbWUsICJ4bWl0X21vZGUiKSkg
ewotLSAKMi40OS4wCgo=

