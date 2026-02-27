Return-Path: <netdev+bounces-261991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPa+JVoXomnFzAQAu9opvQ
	(envelope-from <netdev+bounces-261991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:14:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D01BE961
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944CF3193AFB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FF478845;
	Fri, 27 Feb 2026 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCNmzEv0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE038F938
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230143; cv=none; b=Dnwz+HnQvVpGr/XcU5BiGTISVAVIkF4rOC0zkK91oMpP8dAOSwzXfmYFLT5fCMzCfsR2LJW2XuDQCxCuiZwu+OEE2iJwahrEhH5ioBW2A4l11Oa5w8geKTZMaEQpHtymsMS1ACzydJS+yMT/5Rm5btSNnTfZ3gYVny9G7aWM66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230143; c=relaxed/simple;
	bh=g52lWZ2BJhmaU3XhcI1tqgUu1F+AiLWiTLQiV/2kB5Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gNv7fZHIMgvUoIVNYAdpZVxUSrvlUlt9VacB5bcf/vkljLgNKE8CC62jIadG8nSJHEgjdRK1ZptqQiXkcid3SHQRlSHpkVK82owFytxVFhHL8stwemcNFGP80B4uYJGMEaJ20zFauJJJ5nfeXbsS9O/lAR5YZoWYrobVNXXucyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCNmzEv0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so27913285e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772230141; x=1772834941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpQLAtPq95+27gwOuFC6pHPYgpNU+EJSdGSEzX5AZJc=;
        b=fCNmzEv0jHO3ekO2J6akvNmV1/B+IGVQx7LV78fuUn4naXaGvhGoKAF/2dtDT41Chd
         q/ofCLXmXdUHziZfetxGFFOcI4qrgDA1WKNM3VTTcLn1UbTt6NTkHDFVTUMN3SyLsapH
         FPC0V6pMjnENjr2KIk0RS8HAWZdogvMsicsJ/gXNPZIuErNXK1Rx77Ffg7R+wjPVxSNP
         TAFrtW19cAXRkE3zI2bnhkzmSbetcdQjDCl0S1t2VEpLrZXOs6OyI7rGjd5zXPQmlfS/
         dcX9iBZuEOdGMfFEnv0zJ1yUozT9nXwttYAtskhDX1fX/I+gtT9tjqSvIzQnjsy/7t93
         XcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230141; x=1772834941;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpQLAtPq95+27gwOuFC6pHPYgpNU+EJSdGSEzX5AZJc=;
        b=XHMt1NGKlZaLr82c6UdYMXEmY9+zBPAcUf/lWIulkgEKC+Or4ARYqaaTOpqxcffxlA
         Ik26FwSNORtKAuT/NaGGjq+o3ntfo4QesKik0giUxwvEPF/+Fl4SlQqkY3OdZPPdmHge
         0xWGPV1k6W2rTjzaKyNSes5jk7eOlJQEjq1Qf4+VNHr/vZ660knoRk8MhUxMSHNGBw+e
         B+SdjsqAv9YLxQy7ByaWm64sDKQ69IYDU/LqQ6Xx1H8zaKEUMDupUrhieNw1ciMQAzYp
         1fIZ03Yf7eHAR8fsj5aEbN1Hgc0+depPk4/YMlGETT50S/WXTDG/AAE9e6gFkVXvPgeO
         Lu9Q==
X-Gm-Message-State: AOJu0YxSnzYhAoAYJSjj6JzjdNbzrihuGC2N0AHbvmg+RmsobusxFL2W
	AhY3heQ6z9kZhJKkbCAAkWvqNleddwbQDYhRnEZjCntDGuuywX+TZLbm
X-Gm-Gg: ATEYQzzHhejmmUb08NXQXB2CViJJnYHIsaa3DmZrFWzLc2xBjFZu+RMVOt1llQn7iG5
	wByfZ+MJRYOIAbd6JM1AGW0ldO/mCyA3e8npXB010Kx4oU8xQUm4HiDGu1n9qmi6xIqS8LOG/VW
	glnHo6WtjK9Kt3yIIaitzwxqT7wH9Zj2BSZxDiMy4IeRHy4ckD43zdx4Q2zONOS8RXrXOEWr2fS
	EqleKlpghIRPFwovK8oUEKM5i42RefFTLi7TpCvxFsDIlQ66kSOfzcyDvTrBN14p3oEzrJ9qKHM
	wtH1nxBlfolxMize16pyUCPm50ACGWmgg4+Gppxtcpeb6jXD5yVnBd2XpiVFjjwyDaR81GzEj4F
	0y31vP4RPNmFOAin0CpioTv0xwJF/4XaM082WI6B4IChtNA6Wy4lZ81GPRK9e1EhJl5CGd75ZEg
	fkrGmjmcPKdqZzaEgVzsdJVi/OetIxVDZ1KgzTz1aYQatO3KHuv46Lf8sEAu8OGR9qWrM8YhOhR
	eLFu1KCNpZwqrc7LDytES74wl9aa3agGFnJFizHohe9EUqcxD1aiqf5ey1eTC7sSA==
X-Received: by 2002:a05:600c:548a:b0:483:6e32:50d4 with SMTP id 5b1f17b1804b1-483c9bed9bbmr72364395e9.18.1772230140790;
        Fri, 27 Feb 2026 14:09:00 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf016sm112308385e9.5.2026.02.27.14.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:08:59 -0800 (PST)
Message-ID: <c20f17bb-3489-42b5-b8fe-457245ac6cb3@gmail.com>
Date: Fri, 27 Feb 2026 23:08:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/8] net: mdio: constify attributes and attribute
 arrays
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Language: en-US
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF7D01BE961
X-Rspamd-Action: no action

Constify attributes and attribute arrays, using new member attrs_const
of struct attribute_group.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index fb2bcc69c8d..750b9165086 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -192,12 +192,12 @@ static ssize_t mdio_bus_device_stat_field_show(struct device *dev,
 }
 
 #define MDIO_BUS_STATS_ATTR(field)					\
-static struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {		\
+static const struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {	\
 	.attr = __ATTR(field, 0444, mdio_bus_stat_field_show, NULL),	\
 	.address = -1,							\
 	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 };									\
-static struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = {	\
+static const struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = { \
 	.attr = __ATTR(field, 0444, mdio_bus_device_stat_field_show, NULL), \
 	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 }
@@ -208,7 +208,8 @@ MDIO_BUS_STATS_ATTR(writes);
 MDIO_BUS_STATS_ATTR(reads);
 
 #define MDIO_BUS_STATS_ADDR_ATTR_DECL(field, addr, file)		\
-static struct mdio_bus_stat_attr dev_attr_mdio_bus_addr_##field##_##addr = { \
+static const struct mdio_bus_stat_attr					\
+dev_attr_mdio_bus_addr_##field##_##addr = {				\
 	.attr = { .attr = { .name = file, .mode = 0444 },		\
 		     .show = mdio_bus_stat_field_show,			\
 	},								\
@@ -265,7 +266,7 @@ MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(31);
 	&dev_attr_mdio_bus_addr_writes_##addr.attr.attr,		\
 	&dev_attr_mdio_bus_addr_reads_##addr.attr.attr			\
 
-static struct attribute *mdio_bus_statistics_attrs[] = {
+static const struct attribute *const mdio_bus_statistics_attrs[] = {
 	&dev_attr_mdio_bus_transfers.attr.attr,
 	&dev_attr_mdio_bus_errors.attr.attr,
 	&dev_attr_mdio_bus_writes.attr.attr,
@@ -306,8 +307,8 @@ static struct attribute *mdio_bus_statistics_attrs[] = {
 };
 
 static const struct attribute_group mdio_bus_statistics_group = {
-	.name	= "statistics",
-	.attrs	= mdio_bus_statistics_attrs,
+	.name		= "statistics",
+	.attrs_const	= mdio_bus_statistics_attrs,
 };
 
 static const struct attribute_group *mdio_bus_groups[] = {
@@ -973,7 +974,7 @@ static int mdio_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-static struct attribute *mdio_bus_device_statistics_attrs[] = {
+static const struct attribute *const mdio_bus_device_statistics_attrs[] = {
 	&dev_attr_mdio_bus_device_transfers.attr.attr,
 	&dev_attr_mdio_bus_device_errors.attr.attr,
 	&dev_attr_mdio_bus_device_writes.attr.attr,
@@ -982,8 +983,8 @@ static struct attribute *mdio_bus_device_statistics_attrs[] = {
 };
 
 static const struct attribute_group mdio_bus_device_statistics_group = {
-	.name	= "statistics",
-	.attrs	= mdio_bus_device_statistics_attrs,
+	.name		= "statistics",
+	.attrs_const	= mdio_bus_device_statistics_attrs,
 };
 
 static const struct attribute_group *mdio_bus_dev_groups[] = {
-- 
2.53.0



