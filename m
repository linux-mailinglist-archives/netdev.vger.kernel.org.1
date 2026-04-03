Return-Path: <netdev+bounces-274970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC/vFviJz2mmxAYAu9opvQ
	(envelope-from <netdev+bounces-274970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E3C392D94
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12B353015FD2
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A129DB65;
	Fri,  3 Apr 2026 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d395/uP1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPq6kvsF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F142E11D2
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208779; cv=none; b=EWitD7sqWdtr91C3zOCa6F7K5rrvq2dXwcqMlo97TQw6jxviwcUCHKBcwIBHqXbCU4cQjlVriPC2FCVfZ+obENRi+dhPpzMMyeyuP7xsyHUKankHhLlVninZBZSnKBtiVUltXs4TEpqaHUmEKzTBbLmPm6znXfs+71S4fXL/eWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208779; c=relaxed/simple;
	bh=cv1n3+Y6D+oKSnZC7Rf2LuWBrgJHOPCt+mhyNABBrEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQCShZT2LFiFUKiQA0kMkZ/R5s5EswWZraidf9/gX3b+ez3BxtA/8Qhyy2wQ4kOt1wb7njnhcN0owxwbeYq8ZOICfMDZVmyaRmSBq3KgWqP/AJU/vbGyuH1ZxqZFemqSyeaLav3pm6SuceePJivrwT1lVDacq30U9XoBgVMPjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d395/uP1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPq6kvsF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775208777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OlhvOOy7p63KXaOzp0l12f0csTlzcyaDpAiq+n8anCo=;
	b=d395/uP1b0xjWgidIt9FYPWvVP7tZys7D8Kh4NRc4kuq0BbNWXF/phRxV7lZTPuSGCsnjb
	LSSWAJsOU0VTlannIlwS4NXuC2YuMt93cRzczj8P/rvkOPjEh9VX0ShLNlKLITUgEUDNo2
	hqhFf908Mz9XWfZeXoQxhPXnWsyQgu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-84iixw_OPKe4984BFhsPKw-1; Fri, 03 Apr 2026 05:32:56 -0400
X-MC-Unique: 84iixw_OPKe4984BFhsPKw-1
X-Mimecast-MFC-AGG-ID: 84iixw_OPKe4984BFhsPKw_1775208775
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48544725bdeso22654575e9.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775208774; x=1775813574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlhvOOy7p63KXaOzp0l12f0csTlzcyaDpAiq+n8anCo=;
        b=FPq6kvsFKc4JnvSC4S72KwKn6eQrHyr6Nu+dcoSNAwkE3cIISqRK+f1/Ou/kLQSPWF
         fJdpRwYxKGhG8rCB65Afs6EuFa8JRkZDGrI22J+RCYLTXMTvTqWBgzbtOhxQHCLwbX3H
         dwZHtPca273ExMbFBZvo/anduIiMaL9XeGA7TMOoN/0FV8XKdp14Ekf59oxRhElhLgW2
         +1wLbDy1lA1S/HO4zuRKpICvyIVHgd873AodVXrUL+d0NTBwAq4YPu8lhnLBh+hVoOK2
         Y5RUJd33HEkt7g8TKPppCpQd7MzrPOtwwqjw39ALVI0aui0Xb7Qv59vPwrJckDUylRcB
         YxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208774; x=1775813574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlhvOOy7p63KXaOzp0l12f0csTlzcyaDpAiq+n8anCo=;
        b=Gky0IaoNFZzhO+VDooRPV61HQqcb04YZIJG/wZ1y9DfyoxHd0lq5KgsZjKgCIKYNoX
         9b16D2Vik+e4aUiOzIIE/NhwRjvdU2Mdp3Dr6Ot2MK2QfKRKHQi7iKHnTMvfTpAScXu2
         U8+SjdzjHdTKkuAPcZNC5ytw2sBxePVobY6hco1OLZNynBUu7sQHEez/XD6yEhpU9Ntl
         AmLBt+LdR3es4F73iS9RTRtVflQLFpeMPrzMdWrkKm/+GX3NCpvFbHfL8I5yP3YE4YQa
         uCO9g7Tg7kvTib5ibtUfCkEJByw4aF/SyIaogAwKZVkSp5RK00L0UThjKPny5rCUJEIP
         Sevw==
X-Gm-Message-State: AOJu0Yxjz8mCpIg6c8s6xj+ccMI0fPdSeHtWVfsCRFppH+FrCrh68SaE
	OAYZGRv1eveFf4J6NWHsqdalSYOZ8L5ug1O4dQYu5NHKuxL0XqC0cKGDLntzXSa6Qzj0pzEG8aW
	5Z6Ly9usliG3EaD9TrkgNVJSbYp3MHmMQ6b33wgHrJeyIF/GusJL0EguuJJt9WX/SA0zb0dyUd9
	QdVeMi4oqdXTPl4mKUHa9sXTplx1XAZ5UntiUUlyouQQ==
X-Gm-Gg: ATEYQzzZsWi2d4Im6OXC/AVMtmKxO4joPLqFbrcWPdCzWk/L0wfsNV5zCsQ1s+1m2Vx
	Dt+vEuXTd2JrHZoQfA4CsJD6Om+qv459uR3ygl/M1BX6k/IZYvYur2PCXLVgEU330DOMeTpzEA0
	ucHjjsojqH2jf2M77PJp59WYJ4muNBbTkKcC6mg2mYPvhKOF4pRss9BC4WyJYU6IXO8IJlcQK+3
	ark9bpeUxEFLeUc2jBzGQ3UGA+4Llyg1iihQXsrCqu/2aCtrPMkROT7zOnw5uRDwyZMSpUaLemH
	I2ODbTVXmNzH2AR2ZM/lfLhOISMxCQjkWXihWneWpjiYfTyK/RXJ0XDNxl36sJGSf6ZhubWG2Co
	B2NdXSBwi7VZetvEFHiZ0/riaKR+UYvxyJ+h1R2fbJwyNAb9d33spK9STOaOAYok=
X-Received: by 2002:a05:600c:1d86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48899719a00mr32512515e9.12.1775208774452;
        Fri, 03 Apr 2026 02:32:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1d86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48899719a00mr32512075e9.12.1775208773785;
        Fri, 03 Apr 2026 02:32:53 -0700 (PDT)
Received: from stex1 (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm132198625e9.6.2026.04.03.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:32:52 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net] vsock/test: fix send_buf()/recv_buf() EINTR handling
Date: Fri,  3 Apr 2026 11:32:51 +0200
Message-ID: <20260403093251.30662-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274970-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50E3C392D94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

When send() or recv() returns -1 with errno == EINTR, the code skips
the break but still adds the return value to nwritten/nread, making it
decrease by 1. This leads to wrong buffer offsets and wrong bytes count.

Fix it by explicitly continuing the loop on EINTR, so the return value
is only added when it is positive.

Fixes: a8ed71a27ef5 ("vsock/test: add recv_buf() utility function")
Fixes: 12329bd51fdc ("vsock/test: add send_buf() utility function")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 9430ef5b8bc3..1fe1338c79cd 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -344,7 +344,9 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 		ret = send(fd, buf + nwritten, len - nwritten, flags);
 		timeout_check("send");
 
-		if (ret == 0 || (ret < 0 && errno != EINTR))
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
 			break;
 
 		nwritten += ret;
@@ -396,7 +398,9 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		ret = recv(fd, buf + nread, len - nread, flags);
 		timeout_check("recv");
 
-		if (ret == 0 || (ret < 0 && errno != EINTR))
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
 			break;
 
 		nread += ret;
-- 
2.53.0


