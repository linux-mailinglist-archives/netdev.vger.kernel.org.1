Return-Path: <netdev+bounces-238947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F6C618FC
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 112D54E6905
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1782F0C6D;
	Sun, 16 Nov 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hXRvsL/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2025333F
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763312971; cv=none; b=d5eUJol3FB/+ZDEKTZ5ulv1nEfOp9n34PZSRCh6UAacm4i+jLxIZ5TdfBHmCBTSldH3oEtB6x8vt5PaAXHWIqckQSz3af3S9X86xipA6v09PURtqsIP5B/dKBikqPQPKl8cgHUzH5VXiRLWjADLjI3f/fiYGIWgvf4kN1vVF0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763312971; c=relaxed/simple;
	bh=TUz/go8J+qPOebTt30XBqY4M9/navzJE1WqOt9D7aRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SR4sLtLKYskk3hg41MVOYUlfqNJBuq87m3Y2uIrvgdrAh9DqDu7q+uqq9Ax6GkCQESzYzKoewEzb5zvUMZRL//1T7yHJ9XHrciQu4oE/sw88BWxEx6pLNHal9G188vEgwmlh32zlbCq2kgq53R0aqaUam2BXnI/ZFhenh5vnRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hXRvsL/W; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so2120011a12.2
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763312969; x=1763917769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcjT+pMab7Q2hqz/bv9mPGg2SHjUkPMu35rj7wMSjDA=;
        b=hXRvsL/WuCSzP4b62J1mnAY9Zz/jmwL0OZNVCOtKKaSzKM303cubs6vwetdrkGXpbh
         e5KwguA4A0+PZ4nV7NZERpthTm8+8mH9C1WczpgHdKMthcZMI46CONfH04GAHY+FnlWk
         cBzc9RXXGwB9KF9XnKpw1dxwKFM9IjYAUCGzHgfTozIeMkANHsZw1Ko1Ph++I1nZREzV
         kPaFqrNhhjtFN6MdQYUYCVd9ox29ePGa1ynGyuTQ8rrJV0gV4cFWq817d9DskVj+8apv
         WLlvIo8ujz9ziwONr2xV3LWMU2qiiHHALQqmt1q/TkysxEePvIOfOxjPJBvfr/EcCB+G
         AAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763312969; x=1763917769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IcjT+pMab7Q2hqz/bv9mPGg2SHjUkPMu35rj7wMSjDA=;
        b=p3WCP2rJZpuw5/63lALTNq6sa8j5URI/FJY/NiR4jSOm1qh3PdoK3dtrmAEwcGxw/n
         XjK1u4hZv3WDlgt0gvmOe2ddX43/P1IZdRZdtCl8Ll+MyoYtQ4GzCoI4nZU1Hd1xUAR6
         fhvQdU+wqusiLieb003yC/40cGFZFzVCyaCdev/wd9lgL6JXIciwAnT4wCCSBEs0eVku
         7gnEkkZalbbUKVi1S9QBmWZVLkpemdQ+Wz/wX7ltoNonCGAqxtMg/fyWE32vsoC0GdmW
         DHQzplRSJMddRItRn3eStszM/LhWYeYmTVCBGRmlNpUXS4D1QYqlLeU5QCJy8QYX2PL9
         Neyg==
X-Gm-Message-State: AOJu0YywCPJAbgWKCIK5TYTra20AjzJrrKcezaK3TqqAVi9mdTbWPKgD
	InCv3UCHL6kvbES7dIp9Y31FrRqg2zv5KP+y5QI5f3Rhcn8f6zLCzMvhceBdL1MnYujNT76mP+8
	JXC6B
X-Gm-Gg: ASbGncuUeibhO4P88OVDtGYaOk4Na1f8g3Lim0fWmv+gckoMHcsCXw6j5OIPvsxwZm6
	zF5F4RbYzwhdCoHLkNRRTUoSYHDeFXzNkkliNDqZAEEgCLchYGFbOtQjCf7zJZceUvjMrTayaLO
	XHY0Hghgr9x/WXU+9BGYzAgBIXK8VPXqMptPMSWYV41wwmb9qf3jriZoy34yxSguqwIQhr9y9fn
	CYCeMp2oF5BKY7ecAn13WeiVdFHVIOrcGjGDy7EBntelbpd/xxjbZ00FEoCWFG6Fk8zKeeQRP8D
	zGdZKf8IHdV8iZlJrOnYwyGf0J+i8bJjCh9bCDaYA7eO8y1r+lsDAW16z6ugsz1cY26IBhkHzSj
	q/qDwVl2XyRlmHmmCnFyQ3lRxVWgL2eBzSgG0qqyPnfUp2N6MKAsB9BFHCTnJ8+OFT6xbPBz5Sq
	Zi7omtasRWvYfsTs1FCwZX3eQZrPt0N0G58zBvxm8Y1ThON/g27RtGHCI=
X-Google-Smtp-Source: AGHT+IFQLmMRJTKRVW59ZzA03cCRyPyrVteZ2udRj+FnFuzhWXzrr6j2rQgPRMVYHFgckjp7saDH/w==
X-Received: by 2002:a05:7022:619e:b0:119:e56b:98b0 with SMTP id a92af1059eb24-11b411ff197mr3470108c88.23.1763312968951;
        Sun, 16 Nov 2025 09:09:28 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608861asm25116030c88.9.2025.11.16.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:09:28 -0800 (PST)
Date: Sun, 16 Nov 2025 09:09:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, ivecera@redhat.com,
 jiri@resnulli.us, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH iproute2-next v4 3/3] dpll: Add dpll command
Message-ID: <20251116090926.130f3b9e@phoenix>
In-Reply-To: <20251115233341.2701607-4-poros@redhat.com>
References: <20251115233341.2701607-1-poros@redhat.com>
	<20251115233341.2701607-4-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Nov 2025 00:33:41 +0100
Petr Oros <poros@redhat.com> wrote:

> +	/* Setup signal handler for graceful exit */
> +	memset(&sa, 0, sizeof(sa));

Personal preference, but I like initialization vs memset.
To be pedantic use:
	sigemptyset(&sa.sa_mask);

> +	sa.sa_handler = monitor_sig_handler;
> +	sigaction(SIGINT, &sa, NULL);
> +	sigaction(SIGTERM, &sa, NULL);
> +

Current code is good enough, no need to change.

If you are going to use signal for exit, why not use signalfd() which
avoids lots of problems with interrupts in the middle of the loop.

Checkpatch has some advice, most of it is not applicable but probably
want to look at:

WARNING: Missing a blank line after declarations
#1146: FILE: dpll/dpll.c:554:
+	bool need_nl = true;
+	if (argc > 0 && strcmp(argv[0], "help") == 0)

WARNING: Missing a blank line after declarations
#1725: FILE: dpll/dpll.c:1133:
+		struct nlattr *tb_parent[DPLL_A_PIN_MAX + 1] = {};
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_parent);

WARNING: Missing a blank line after declarations
#1761: FILE: dpll/dpll.c:1169:
+		struct nlattr *tb_parent[DPLL_A_PIN_MAX + 1] = {};
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_parent);

WARNING: Missing a blank line after declarations
#1790: FILE: dpll/dpll.c:1198:
+		struct nlattr *tb_ref[DPLL_A_PIN_MAX + 1] = {};
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_ref);


WARNING: braces {} are not necessary for single statement blocks
#2480: FILE: dpll/dpll.c:1888:
+	if (json) {
+		open_json_array(PRINT_JSON, "monitor");
+	}

WARNING: Block comments use a trailing */ on a separate line
#2508: FILE: dpll/dpll.c:1916:
+			 * If monitor_running is false, we're shutting down gracefully. */

WARNING: braces {} are not necessary for single statement blocks
#2516: FILE: dpll/dpll.c:1924:
+	if (json) {
+		close_json_array(PRINT_JSON, NULL);
+	}



