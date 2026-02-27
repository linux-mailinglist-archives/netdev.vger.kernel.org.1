Return-Path: <netdev+bounces-261881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EPfOCa1oWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE21B989E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECC031462C5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81543634E;
	Fri, 27 Feb 2026 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6DLQYqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB303E8C6B
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204979; cv=none; b=to0o2AgyxA/hMbAAqcTu0Dg9FWcev57tzdPafgRFkwzOJE1vVLNL3WlGPjlekJIShgR9hYyMFwCzCEGo5fqQeeUVloaf0H54Emn4NHymCgsZL4G8IMgvh+aGlcs1cb2fjEni9K9yMxm/MfgbyhgaJsrw6f9OaIbijYGT1JqdmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204979; c=relaxed/simple;
	bh=YfX2g470dRQCs1s3q3T0iw/zUQuuNWiQgKICrIJTCt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExcjYqqsT0F+p5f+ojVNzQ7Oxga9/+19xvuvRmH/C/UrW81lIh1rUBXrFE1MmZnZufeYq7ImOj6rrMoBX+3Ok71By8GzSEKTZaR4vAIgXtWHJIpkdlxncmAv0zxZZlRGK3WJgKtrZfjdMlGNFl4TefdsE/+OnKF9TUY1fvSHtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6DLQYqB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a964077671so93115ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772204978; x=1772809778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfX2g470dRQCs1s3q3T0iw/zUQuuNWiQgKICrIJTCt4=;
        b=b6DLQYqB9MlFY+Is/m/HyI3mx5yN0t+0elB9Mzazp/Y3znVzFRfNf0iBx3J6cpeJFC
         OJRU/T+q3EAttj97HqRMb+xsON21iIyRXvCB4bJaAt/U83pE2coE90EiPb9AIf/INEyV
         ZMUYxeqDiJiAA786vci7I0n6ZdC6Mvx+/9tQfW5koz1oO7QLbS4fLBfgBHpOTAvvWIGu
         1ugBH/jQnI9Y9KdTlWmncrtFVmr+QiKN9vFXcM2YlTk2A30if8eORtSM234AoTlmaWCl
         uh0vYfYmHNKzL2EYP81D+WPb1kqYGf8RKWes0fK/DlyXQt8zs85vCF6RMz9Ki9x8eM3f
         nwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204978; x=1772809778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfX2g470dRQCs1s3q3T0iw/zUQuuNWiQgKICrIJTCt4=;
        b=JjznxjBgYDpwR2w0RM1r/P2t3CU/XO/BJ04jcdi+Cfr6Uep3Kdt3EWF8Khjyo1Fj6z
         gZNSMA5bO3vgt4O2MkhETuCEH0lSAirwIA4cnMJge2Q5fSZoR/NKA0hT8xmFzAzOGcim
         YC8VKVzLT5ZR4nPwgyMGW8TcgINfbFiuHwUXjbmcKG+kXluI6dzX8L30ohWsvp+6pUkj
         CK/JxP8/sWmM8cpyYC7DWc2JcQAjd5rQiKLPr8rA7ookyt/YGftflPZpcAHkxC3WY5U1
         cppzS9f2hqZiq8lxA9owrNSZwdtInnfb2VWcVTmVQB41WZH9gailSvF+xVKBIHx+Yp2A
         1rLA==
X-Forwarded-Encrypted: i=1; AJvYcCXnIKj9edhaNjUhhf0uyfaLJCSfiXHcngqYEJVCLlYkrL6wRXJZ168Qyg83jKUH/OpkgBC1q+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCMV/rQbIn65sLNBYEaWGjrjYeZ+b6a6WKGgne5+vYQA0m2fF
	kJJExX4Jv+zFli3SRbY9rlo7gO9whpGclcUuEgJl+gdDgwgVw0Ku1CSVpog2dq725w==
X-Gm-Gg: ATEYQzxX+SKsQUWeHF+MSrbxgCqYU2sOYGqzizB/xfS7qSX8Io2kF3NrC3td1eRTILt
	0clxIJ5WsLcKLyExDzBZCOQN0Ytnep1hVzjA15dSvvlPDTcJqOQjnRmtlOTVmecgcA4xKQd1EQF
	RDPSZfUQ0JXPfKWkTFV5Itovds9zcCcLjITAf4kbauCB82fewHpMR7ciEPyhS1OWAJaRsBrTxIL
	EgMZnyG76pdfSrzQWyujicEY2xAdon9bfY1T+kdI7GFgoQgZyUfsdmb391iVMvF0RgHTMCBLime
	YMCjE8oTegHV+kegkBbQjpc+oEYn2xbVRVc374IesqTw+eQ9fDBFy09PLc+1XCioOb8t0Lpvj8K
	HQB2JZH1xbmh8bZqsO5YckAKsUlUHm+tP56DGiU4LlCFoVYXLkdzCmvpGLnjFW3qjReFHihu2Y8
	0YcjIw0A6IcvNFPYgB8NtMLIxgBmgQX+NZKGa6UWhNCo9ZcZ4b7d4v+1+ChA==
X-Received: by 2002:a17:902:ec83:b0:299:c368:6b1f with SMTP id d9443c01a7336-2adf77829e3mr5978935ad.18.1772204977547;
        Fri, 27 Feb 2026 07:09:37 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359131aa5afsm5045853a91.0.2026.02.27.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:09:37 -0800 (PST)
Date: Fri, 27 Feb 2026 15:09:32 +0000
From: Jordan Rife <jrife@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, daniel@iogearbox.net, sdf@fomichev.me, 
	netdev@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, 
	yusuke.suzuki@isovalent.com, willemdebruijn.kernel@gmail.com, martin.lau@linux.dev
Subject: Re: [net-next,v1,2/2] selftests/bpf: Ensure dst addr/port are
 preserved after socket abort
Message-ID: <mg4c5j3brafehwfbxemda5viihhrtz7x34th5y3mfsme4zpu5q@i74mxbf7iown>
References: <20260224190516.2102048-3-jrife@google.com>
 <20260227033658.2599813-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227033658.2599813-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,iogearbox.net,fomichev.me,vger.kernel.org,kernel.org,isovalent.com,gmail.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261881-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62BE21B989E
X-Rspamd-Action: no action

> Should connect_fd be set to -1 after calling destroy() to prevent the double
> close?

Yep, I'll update this in v2.

Thanks!

Jordan

