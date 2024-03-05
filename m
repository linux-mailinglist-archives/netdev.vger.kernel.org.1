Return-Path: <netdev+bounces-77325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37787871454
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BEF2811AA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADB374FD;
	Tue,  5 Mar 2024 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E54Ie3iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818A2F44
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609624; cv=none; b=OrCgJFGuNKOrbkGWvGww+Y8agUsWopOMxu18gct0r7KQxlblDoybB2M3E7bqJdEeNj8SHkFYm3sCFQWEaD3KtG1oxJit9uzRPjqWE7Q9AnsZVDKBnIJ3coTmcnojgT3hsYC8mU22mpVKG2aDdp9UZ7OvNeDwLKR1xCKbAWDp9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609624; c=relaxed/simple;
	bh=dB1pzAhXBNIf5GMFwNjQ91oBuCG5qem9ssCIj/JBZ+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M+1Iqzj5wymnh13aBncqipHawRfxsmvQGdkgegEfH6WvjIOKbZjJheP5wYoA1zDfOPGaJVb4ziLDdfhzdPDiye0N0Esw//Ix8OxFVv5qN3zCN1obQrRy7MXGAnA1QptLGWa7xel/bhgxCDLr56wWhgNMsOcb/iFgKHQKjXkz/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E54Ie3iz; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1ea425a0fso1056886b6e.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709609622; x=1710214422; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dB1pzAhXBNIf5GMFwNjQ91oBuCG5qem9ssCIj/JBZ+s=;
        b=E54Ie3izjUi8ak1kilWfYFAVJJv5oCpupNQ7iudkSvrREj7m760Y54ROhVLQgMiSEb
         RKFWoExrgI7fFfDjS0aq5c1+5DxiUKqijytWSUffDsAOWAAuXqKl9SNY0jXa6YKVcwok
         WI33oSpttv7MqZccpWS7t8fWRfa7ys+0xV5i5IVg8wGjGMJgQhgKslY7/vwXihCVfaT3
         r2mJFEnFXxwCqPUi9L4ZbRjc5KAVMGuErO2gfiTSWxWcQB2O7I7Ko/l/qvhCdb4vRxmS
         DCNZHvrYozV7ESf+1Guo1qmo37HqkoIPrN403YDjz5j4X7bMk+A4dGn9z1qrMnxV8W/w
         NOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709609622; x=1710214422;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB1pzAhXBNIf5GMFwNjQ91oBuCG5qem9ssCIj/JBZ+s=;
        b=jXo1g7YkS+15LvS4ZPNfe5//gTgfuL7ciToVICSCX40kAQDwlFzw17Z4FxLTSqxreL
         8mwmEPwMGNKbX1R2Tvd73UCtct+XSWk0IXl7msYU32hQtQSS32RhLMTk2c2rktsOvDWU
         Jw2xJKuM5WVkYRjxRu1uC9uEceK8ByaSeMRH1HmbbQVwQNRQi/BK6Tjv2jppVMW5W9cH
         OJTVddql5so4CK0LTvPo6RfPAoFjL5f0/32gOnJY7enlcxB/50vJJ9aYaHctFp7BLWYm
         4nMJFa2l9Ii/3Pge8EhDwgL3EHJSwLZ4Qwl+Qz5vaQFhSP+Jgs861x12+dO5OQwE/49j
         fmWQ==
X-Gm-Message-State: AOJu0YzlOXBM8JOfKrPTGSwixHrEE1LfdyrI4DAoch8eU5l1BJHXwKRS
	UsVuqeVyOHQaYh3GvowCTdoeiy3NULJr20+oQgFKlx6hpftyGTJ0KaEA1j7KPkFX4w==
X-Google-Smtp-Source: AGHT+IGJlqe2WEhs9jcKt9U4e4IT68FHj4nuNAjlYzYRnJdEm1h30hv/1wzr0XR+81QrvARpSOFXNQ==
X-Received: by 2002:a54:4803:0:b0:3c1:ef0b:f3de with SMTP id j3-20020a544803000000b003c1ef0bf3demr628275oij.52.1709609621996;
        Mon, 04 Mar 2024 19:33:41 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c2-20020a637242000000b005dc36279d6dsm8145280pgn.73.2024.03.04.19.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 19:33:41 -0800 (PST)
Date: Tue, 5 Mar 2024 11:33:38 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: bonding: Do we need netlink events for LACP status?
Message-ID: <ZeaSkudOInw5rjbj@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jay,

A customer asked to add netlink event notifications for LACP bond state
changes. With this, the network monitor could get the LACP state of bonding
and port interfaces, and end user may change the down link port based
on the current LACP state. Do you think if this is a reasonable case
and do able? If yes, I will add it to my to do list.

Thanks
Hangbin

