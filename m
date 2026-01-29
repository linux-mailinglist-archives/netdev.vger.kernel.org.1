Return-Path: <netdev+bounces-254832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNKkGOB7e2kQFAIAu9opvQ
	(envelope-from <netdev+bounces-254832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:25:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D482FB16A6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF31300B457
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64D2FB99D;
	Thu, 29 Jan 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UmpnOWEJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340102BD5B4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700316; cv=none; b=JhHLBMY0Nx/2tJsKN6UwtRRyWHs7e5U2ovooVEJz6JLafuszx8iQixFHIn4KhZifvAXV3t2EmenXvMbaMB3s6ZnhAErfsgywDcpu0hv6lqh15M425qJ9qol1XURBBbSDlCnUQyDQ9HIi3EWeQEcVQRGK3aF/DW/ro3SrcvymASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700316; c=relaxed/simple;
	bh=yT1a5IvWBtJ2Bz4QRwOppeETDWam3Qzl1m0MpHi2RZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6sfoJOnbpmw/I/yNRXPxN86Hy0KeGEdftj0dJ/MsPqHOWXdRmbLidXdi41xIv66dggx5mSUbNyoffs5ctfsVAJrlzk9Z9VLVXFfvcguTkg7OC9yA/AGZ+Di8TtTU7tRmpKc+shnmYFobqd+E3Kh31DnjlMWMgR0CzCBcdT+ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UmpnOWEJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so16190695e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769700313; x=1770305113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChHYN7282bLPbejQbl9TwWz+ztfRLEC9/QcbOYUXVJE=;
        b=UmpnOWEJ3JqT8p2veFolj8IoDej5dlEvVjjlXvNfduPcsrIrkMK/6ojV1YbZ243b31
         oAUSIf1t1OJIu/+AVP6TwQ2MCQXmKy9BZakq2lBXNEr5tDOCwlYrsY7zpcrB1XcHpV2Y
         AUvd8kkbze2QDkLAEjApJcRK6YIUluWinUdlxLGNOifL2EY2bm8RWb8C/KmcidCdRy5R
         UE9BNxyV8Vs7EtddD5kjQrV6SIza8Gos9TamKoC61PR6OgTzUMu6tcYbLLiW8XlVzCD4
         OLf7mLI8KirctvSaX175okkiTswLrzcGCDpNZVfqe1JW4m1mp2bliN8UBOL1Qvsysxyc
         V2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769700313; x=1770305113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChHYN7282bLPbejQbl9TwWz+ztfRLEC9/QcbOYUXVJE=;
        b=Pm2BDanU3nbrBTJ/5zBweFwfZ/eMD+J+u61sPX5LCMS+eLEZ0X1uuNapUUJ3CaEVQG
         MGseWzhqiqflgdrIlelILKJU6yLSIcOPd+tFp+qNHheFlow/ekpAWmBfhkZ/FeL4fAJA
         KVR7kBOQJnfRYetRgHHf5dW7YUJoiVjIhSgu+HdHHpjcAMUxf/hq3xzRXf31vzDpyds5
         CEG3C4h9AmtUi/k0oB3/WUxIFMzrUsilUAKjD+tWu21b3eV+CFBTBN02WG8jNp/GOJZp
         C32ovSw+esH9BxakafWAQxUqJR/9QGYgUOzUkz9uKEOXLmm1RG8RwUtpmcEbhjxJwk/h
         y1UA==
X-Forwarded-Encrypted: i=1; AJvYcCXuuyXogCOUcMT+fF3SdxbCwyXfTIhrlpdyJW6m4B+b0sixGu4KpVHIBA1A3hgXsGNIKpi4oZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHC10q/tiqEdVKn8vFWBFUktEokyR6NdwXAcdilUMkMJWaNxnm
	YPp/x7QZYHaFjlF8TcPNKVn296gN6l01lXZ+iPssbVcj4jtUcqH+52M9sEQeCGakrG8=
X-Gm-Gg: AZuq6aJeCRWpw2hMTXAUCWw2hFHp8oZIOSI2i18Yf3PZiyk9/iHcQISKUTOAjqcMqAQ
	R8rlX+2PktJBWASgN2BDBrnKsOPPfPbIUfol4gW3tHLMqf9/zWLdK7h9388MgdRDmKB8sC8R66f
	5Hglc0rrq1HSh6N6SVLaV8al9Rhkt7z4xf0dAF9HoOgRdg2O5IqohD4LRE69XDyOlp9pheA3ZwL
	jKGrUaBLhA88yEz367KdVaC+DYVP1U2tyTQP9D4/9L2IQucKQgigeOAwADOgL/UPTu0GbTef9As
	Xa6PdtS5hg2SzsQDSH1cl6iHUllKVq6BBI9aXBAZUCC6RgYyvTaegb6f9xgaDfO9jybfkVc+zx+
	tRiiQRcbhZeCJShHlgPSF+HcBWK+zr1i2Q55Wna5EpFfFaDsczMPSJ+v1gQ5Tt0P/KwWE6TiBkI
	GlP8If+vPPRHUYvg==
X-Received: by 2002:a05:600c:4e91:b0:47f:1332:e5f with SMTP id 5b1f17b1804b1-480829b5cfamr47317875e9.12.1769700313429;
        Thu, 29 Jan 2026 07:25:13 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce5ec6bsm149207685e9.15.2026.01.29.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:25:13 -0800 (PST)
Date: Thu, 29 Jan 2026 16:25:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	john.ogness@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 4/4] netconsole: Use printk context for CPU
 and task information
Message-ID: <aXt71R8OVszVvu_X@pathway.suse.cz>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-4-93b4ddbc181a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-nbcon-v5-4-93b4ddbc181a@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254832-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pathway.suse.cz:mid,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: D482FB16A6
X-Rspamd-Action: no action

On Wed 2026-01-28 06:17:40, Breno Leitao wrote:
> Use the CPU and task name captured at printk() time from
> nbcon_write_context instead of querying the current execution context.
> This provides accurate information about where the message originated,
> rather than where netconsole happens to be running.
> 
> For CPU, use wctxt->cpu instead of raw_smp_processor_id().
> 
> For taskname, use wctxt->comm directly which contains the task
> name captured at printk time.
> 
> This change ensures netconsole outputs reflect the actual context that
> generated the log message, which is especially important when the
> console driver runs asynchronously in a dedicated thread.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

