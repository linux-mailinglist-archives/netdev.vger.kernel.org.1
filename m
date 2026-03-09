Return-Path: <netdev+bounces-265424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI3WCjSUrmmmGQIAu9opvQ
	(envelope-from <netdev+bounces-265424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:34:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9269236383
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF66301F18C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A760C37AA77;
	Mon,  9 Mar 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JrDx10Kb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EK/MdAWG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFA2EBBA4
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048739; cv=none; b=NXzmeNDr0YW9VqadpqX6qSftFZdQiwfgYFA26a/0v+WrxmAqHrJNQLlu6EdCZzDK4ssoowA3qlvF5WA0kGZ2fgkJSf0SNN5cbiz+A133sLVNmjcliFTJlVKKEprpvhnrwItG685Jlttc+gj03ALSRCKZD+IjnDGtoSV2XDPstDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048739; c=relaxed/simple;
	bh=fFQlaTkfWgpJCgE2DfKiYzJaRZNs0hg9Y5If25AGau8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdMbGWNoMQOWVlTyzQ6Ui9YZz5MzyYudCZKg/GWag5xHeDQ2kIkFVk/zbL6q1AWmu0srmaNVlHm+4VlS31cMmCp8y/dBJa6ywL+tcwwortWnb5ZJDJ5neLMW6Z9LPpavL3XU35s1Xe3APWI3BQPYld6htzD+EykS4wB6Vz45/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrDx10Kb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EK/MdAWG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298F9U53013568
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 09:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EkDzUyDmSGO7O/2EbFa1LNKRPCo5Iz9DS0h
	qf01l9Vc=; b=JrDx10KbCGb17f/P2wiXqbJlFmAvAgu3dYwRJQpo1N7vo4kSOFz
	x3+OiINHDwXJNs/B+pC8XSq6rb7qxJAh8xM6vdtGBhOuf34FbHCjUmyoz0bH6kwz
	/ISiuNM+LRWmCXSecWxS6Z53eJqvtMj2iAbT9TBWgZ7/JqZCQ+LMga6D+gV0bqFP
	Idt8W8cuRENPOcZThSdp/tnTZz9WugGpu1W7gbO3KUtHXJpCx/OL+47W8x6gyELc
	WnkqyPKFmudH9FIG9Zst4oLO/jAOwBcuS3S3GUq/9IJhp7sL4Z+R4nqlTjsO13b+
	2j50oBfmkcUwJTdJcKCukMGLUmbYxBJ9Nhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crbkxvtab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 09:32:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd84943c76so645411285a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773048736; x=1773653536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EkDzUyDmSGO7O/2EbFa1LNKRPCo5Iz9DS0hqf01l9Vc=;
        b=EK/MdAWGEg7JoTY+K6qpGtDIuHLv0l69PJ+mRto35NwSq4aQK4CcYaauChAntyx77b
         1JlO0V8WF7P+FkCppL8ciHxrUytGKHGYsAqUbdBMiAVDpdTA0KggC9b4i/P2FsA1RuQv
         jZOkqB+VtyRnonZ51uP+T0Usvr7qXx/12QmMhc5eZOlWAcch9iXz6GOJBPPm2BWig0E6
         xw7J01/aJ3NsBEZulHROxWa6J8AE16Jg+7Qap2DvYFIk5fB/vQfb4lXopfAxjXgVZX7O
         oOrmMYikMhCnSeQFQk/gMNW790w4MXfyqkfyWfKS+bMlIl7t9z5a+W370b0ggdrRpLC9
         6wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048736; x=1773653536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkDzUyDmSGO7O/2EbFa1LNKRPCo5Iz9DS0hqf01l9Vc=;
        b=P82QB4OEpZaiKM7e4aNbl1oOcYoCQBdnOIqYp7MRIOVhGN/zLn6nMPoQSTRMo+5/ii
         +Zgb46YC+Nck7dOzURP3iIYHLR534DozVTs0jSRJEsX01t01d3cQQMB5U+iSw1u6b+Ik
         BcKEGp/43mUXNWov6Kt1GnYyaJET5nyK3lX5hMSkjkNjLdL8I9R1Xb0q8tajX45cChFN
         UL2nEsS8ePXY7hEwskNjZ/3rQle17Ne3uSOEGE9tHZ9aexsvKK2ecAp5V8ZZT5sKgXWm
         +82xHLrPBtou/g/WqAuwyXHU8U8WyAISu85sgjdMbjfZ/vl68TXxVG9WyvoyKYHp5cnG
         +P2g==
X-Gm-Message-State: AOJu0YzpnNQqxUWEFjJZBEri8iXQ1nKWeLVuFnj4uQIDuYyJJCeQ9LqJ
	VYlwnR+D6uUS8Z4O/iwRBZOmEN2J/1M6z/owslovDTgqcDu/1oH76EXJLAL0CLlL6asW41oOj1O
	G3v0tg52Z17OiD7NpJZT64iMTan3u8fCpx6SvqIt2sZzx2+JtuQqfGZJL86c=
X-Gm-Gg: ATEYQzzUuKthGAcK9Rz8XAu3CRPDwWOXFvu7vxPGd7lcIsP5vGKCAwOjWw60ntPIJ5h
	LOrTV7tKVeE/55yEjIc2M22PGUSvjRVKlk/OG1TpJ3YGS0TevXNlbUIf6ims0WTjxGc2n5pl8r3
	xSSmS07mxqVbIdFiZUVOQqEzZQPqa1YHovjUeLEYTqAzODBz8WWsMaze/Ok05kPSKnUVXOjaDIT
	cTWcRq5y2VIPXBUrDvbRcmQDQMMa8sBFwcbzhYmwa5w/SLW1mL7elYHIPM9ReRoU0WBtSNR/2IQ
	SbvL1rdP2CyziSZm2gz5XnON12u6oK+vZ4ngSU1Ww4tgrOEnq/HgPvXziGQ9KIW4IxCMHU9Rckp
	T7mUiw1VpytaGn+NglVh3PY5FkHIEqYaRMolseA2AyprYqHjv
X-Received: by 2002:a05:620a:2954:b0:8cd:8783:49d4 with SMTP id af79cd13be357-8cd87834f05mr372618185a.26.1773048735896;
        Mon, 09 Mar 2026 02:32:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2954:b0:8cd:8783:49d4 with SMTP id af79cd13be357-8cd87834f05mr372615885a.26.1773048735463;
        Mon, 09 Mar 2026 02:32:15 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ba90:b1dc:5545:17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852ad0ce60sm386087165e9.12.2026.03.09.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:32:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Jialu Xu <xujialu@vimux.org>, Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] Immutable branch between GPIO and net for v7.1-rc1
Date: Mon,  9 Mar 2026 10:31:53 +0100
Message-ID: <20260309093153.10446-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4NyBTYWx0ZWRfX23cUfFxkdVAt
 YbLqluVaNuWs/gHeYUsmI6F+DXwV+scc9Y9gCyHoCEhYuaHToqI4TZKQMSurTLI5Z2kbpHO5Aof
 Uj9YkQSLZn5F7djt7d6nv5qvn+3IUIQQnYIxDh7hyCx/bxveGrESbQO46LntbFuVt2V+E4KKEKY
 XRWVqSeJ8WNY441qZkYlll7X08+85CHpds+92nrwhBAESc+2BKhFPlMtpM+K7rjHSE80WdtQ+tQ
 5GgO3YY/2TPREcUIXJu7b4Bw2qw4eaZnUfPaO/SbfM8vTW148CPsiY8Az7cG3QbB4uPVNgFm71+
 Y61JieqCulZR+YJF3sD5VnCP32uK8D0dqJL/dzrv+zX+zyhaWTfVMMjI+ga6zXOPJ7AYFBfHnGx
 3QO9u9/UYaBW4zhr95E7JWjLuH8zGraZo+Nx1Wp7ETQBuh3r5M7l2JrZFLyBJWnJUMvmdpzp9hi
 rPrtt5Q1ZAiZbscx8Ag==
X-Proofpoint-ORIG-GUID: vOJWOiTb5KonfOQfUpGwAsqYxxnXV8Np
X-Proofpoint-GUID: vOJWOiTb5KonfOQfUpGwAsqYxxnXV8Np
X-Authority-Analysis: v=2.4 cv=LOprgZW9 c=1 sm=1 tr=0 ts=69ae93a0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=68orOZdvLkcCyr1C4gIA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090087
X-Rspamd-Queue-Id: B9269236383
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Jakub,

Please pull the following changes for v7.1-rc1. The first two commits
convert the remaining users of of_gpio.h under drivers/nfc and the last
one removes the - now unused - header.

Thanks,
Bartosz

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/ib-gpio-remove-of-gpio-h-for-v7.1

for you to fetch changes up to b6420bd5aa0c374331bad6c0fa2eb5f0f87cf5a0:

  gpio: remove of_get_named_gpio() and <linux/of_gpio.h> (2026-03-09 10:25:34 +0100)

----------------------------------------------------------------
Immutable branch between GPIO and net

Convert remaining users of of_gpio.h to using GPIO descriptors and
remove the header.

----------------------------------------------------------------
Jialu Xu (3):
      nfc: s3fwrn5: convert to gpio descriptors
      nfc: nfcmrvl: convert to gpio descriptors
      gpio: remove of_get_named_gpio() and <linux/of_gpio.h>

 MAINTAINERS                      |  1 -
 drivers/gpio/TODO                | 28 ---------------------
 drivers/gpio/gpiolib-of.c        | 31 +++--------------------
 drivers/nfc/nfcmrvl/main.c       | 47 ++++++++++++----------------------
 drivers/nfc/nfcmrvl/nfcmrvl.h    |  4 ++-
 drivers/nfc/nfcmrvl/uart.c       | 23 +++++++++++------
 drivers/nfc/nfcmrvl/usb.c        |  2 +-
 drivers/nfc/s3fwrn5/i2c.c        | 54 ++++++----------------------------------
 drivers/nfc/s3fwrn5/phy_common.c | 11 ++++----
 drivers/nfc/s3fwrn5/phy_common.h |  5 ++--
 drivers/nfc/s3fwrn5/uart.c       | 43 ++++++++------------------------
 include/linux/of_gpio.h          | 38 ----------------------------
 12 files changed, 65 insertions(+), 222 deletions(-)
 delete mode 100644 include/linux/of_gpio.h

