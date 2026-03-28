Return-Path: <netdev+bounces-272785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAhLKCb/x2kqgAUAu9opvQ
	(envelope-from <netdev+bounces-272785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 17:17:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABC34F23A
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 17:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD1ED301F4A4
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196763242CA;
	Sat, 28 Mar 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlLwT8tM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8Y0G9Mi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D56221DB6
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714660; cv=none; b=XrIRSN0QjQ9hnhCzRmA1cZEwYL2mKongVXonxmUqJDV6yDIUvhi4vnz8ZhnRt4iC/sVXxi9gny2ApAN0F/Ml9V6TPRSIhj/4yhs2m+JBEW6BeYjIJGwsmIdLq5lPcMwF/+8lSFJT8tNFZHenxcKiYH/RAuMQ+jQ6C0Cwvm3v7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714660; c=relaxed/simple;
	bh=4zHQl7tbZhImnIvhcQOSulQWJPtz+rlgbb7rmD5R5/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=td/l23ktYPmxrGe/3ce56dAu5Z4+IpDzmlvum2EFjKJGvSh9wuWVkzZvcJP7lv8xZjGm8p7xGzx//3ySHucrjXf9YGlGuMuEIuZDJ2THfE3TFmKpQ1G0mq/osHU1RCEkp5eF7mdteSEErsxk8mtwR2fU3wxuoHPDYjzt46XQAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlLwT8tM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8Y0G9Mi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774714657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zHQl7tbZhImnIvhcQOSulQWJPtz+rlgbb7rmD5R5/w=;
	b=UlLwT8tMmXPIX9pGkvEh9MjC9KKDal+bdE219Kzm7s9uXnC0KeiguzAO2uk7Rh1C3dyDr7
	+NCw0Cak+yuLBGgAxV176k7IuKdu9hyH6bl+u1s8jnz33YEFXj9em1maXhqXvtwYbaHdeo
	/4RGXQJDugNEebrDPwFlCGQo0YaADn8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-3EBVe839MAO3D7-lJnbxrA-1; Sat, 28 Mar 2026 12:17:35 -0400
X-MC-Unique: 3EBVe839MAO3D7-lJnbxrA-1
X-Mimecast-MFC-AGG-ID: 3EBVe839MAO3D7-lJnbxrA_1774714654
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b3a0d25d8so1803669f8f.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774714654; x=1775319454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zHQl7tbZhImnIvhcQOSulQWJPtz+rlgbb7rmD5R5/w=;
        b=b8Y0G9Mi+pEjxEg4TU7E2p/SVcXZ1pDNezmTEApo+DMzliUzuDCxoEjEJBipUKfr0l
         sPvRhNDZYzavSYS/H/1psjxxXDuGLt54q8jZSgvVZ0IXt+kBwmWvu0myyaCKkBirTUVX
         uvW7/FXyizTvLsHyDQOgeWA1n/e4kHzVm1SxXqtmwJo8wChHYeawBM6vN/sRbPoUkVR5
         zQV8+a2tJBDeX9yPUDGwnCIW5i7/pLB9a68tsbudBwpD573scBJ5trnflmBhr1Py/Zg8
         cbOpf4yRWLnSmEY/zHXlLk7WOHlrqpZhblJleEKEC1b1pXl5alr+NM0Cwkl7K9hJivRJ
         D0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774714654; x=1775319454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4zHQl7tbZhImnIvhcQOSulQWJPtz+rlgbb7rmD5R5/w=;
        b=Y3MrBMmYhZRHwxmf+gNFdvNUHPMleyOLJ7j3c7cmnty7skB8/yylyzYdACJE1HP5e9
         Fnhywu3dThe8y9Gj58xpWBhNnV2mpAE5x0x8f48n6HhklVVGLDFNSpHav30J4ObqUYZ+
         o8to+yEXBM/M1stJzv7VihB2axlO/LnwPYsaYWAnXh40b9gILPgQFt9W9noUhjQMaBjP
         K0iGTQ1t3N11ElJYJYfzbw9VgcUpF3RUXCeJt5uz0GY1cpj28hXl9MzIAJZo0pIbsm/c
         jJMZHsVTe7fRl8je30oT1g69Lu2UkUnaO9OdrARlxWkgUwP43v49bmVpjiR8O8Jq1Akr
         pEQA==
X-Forwarded-Encrypted: i=1; AJvYcCWLr56Vy0b4M8grFl8ouFe8dP8Y709DTDKB21GPeqpdqkz/RktwNzH+RScyHGCsvaAXXLaYehs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMYlZ6839B8nRSap/y7K0PJkIuSQSD/zpXohSadQvPOtBKuJi
	eaopfPnUt9DVMLhIp8V2KW+ETPbYraFI0kKgkjVHPhaaUM2eWWhJc42BK9vUnQq+gatWdJBbJdf
	IgdZDehACHl4x3+hYYXn5X9sYXHEzdiwxgvOmecIBVDZKFVunia6AW7UgQQ==
X-Gm-Gg: ATEYQzx1B6m+5QLf9xnMxVhgjnrTTWY3d7CXsC2t/8r/7NwDZb/DJ9yADjjDrSdqefB
	98YugC7H9vJNR80y3thdcgQ+15Dnczz+D8Wo0d1bPNYQQKdXGGWtUy0CZqulxq8baaHhv99LY+N
	baJSaRwlfdc2XM4BYzNwzz0n3Ks7saHitX27rI0WGU5j+/TArqXoPyCgj0lVPy83jniggcTt8kv
	cJ8S/4/wdfyPfT5KxnsjXLMHujZSEruGBA/AQcm1NDc4liK+ODdqHfF1NiEGT9ZHtZJfVwpW4i0
	P+y7mqFsd4xqRI7pvI3EQI1mVnO/TUFKBZViVhIZe9JDaXxFATPSTX2pioqjnvuaegMpLwoqvdb
	7NAJHJnV4ztUo5kPwfL1ou5DC2Zd3Ba80mmVKmln7OM6YSnJ+Z4fkVsLeObU28RGsOAJEUjFl
X-Received: by 2002:a05:600c:1d1e:b0:486:fe46:b647 with SMTP id 5b1f17b1804b1-48727f00d8fmr107884935e9.10.1774714654377;
        Sat, 28 Mar 2026 09:17:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:486:fe46:b647 with SMTP id 5b1f17b1804b1-48727f00d8fmr107884615e9.10.1774714653917;
        Sat, 28 Mar 2026 09:17:33 -0700 (PDT)
Received: from air.bos2.lab (IGLD-80-230-124-201.inter.net.il. [80.230.124.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eab94dsm37462445e9.4.2026.03.28.09.17.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Mar 2026 09:17:33 -0700 (PDT)
From: Vitaly Grinberg <vgrinber@redhat.com>
To: vgrinber@redhat.com,
	netdev@vger.kernel.org
Cc: stephen@networkplumber.org
Subject: Re: [PATCH iproute2-next] dpll: Send object per event in JSON monitor mode
Date: Sat, 28 Mar 2026 19:17:23 +0300
Message-ID: <20260328161723.43191-1-vgrinber@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CACLnSDidL2kgT4z6bdHuhPZ+Y8Vb0dgj2tNNj9VDPJ31-gCsoQ@mail.gmail.com>
References: <CACLnSDidL2kgT4z6bdHuhPZ+Y8Vb0dgj2tNNj9VDPJ31-gCsoQ@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vgrinber@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12ABC34F23A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,
Please ignore this version; I found an indentation problem and will be sending a v2 shortly.
Best regards,
Vitaly


