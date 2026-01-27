Return-Path: <netdev+bounces-253993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULOQIJsUeWl3vAEAu9opvQ
	(envelope-from <netdev+bounces-253993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:40:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E47AE9A09B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F03930649E4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F136CDE3;
	Tue, 27 Jan 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSFeXMHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD345323416
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542490; cv=none; b=bCffp4KOLlIzGFYuCK0KZ1mReBvnSNQa6b6kwV5N0boir5+dBu98Z7q2/sdaJGSsFVA0mlhCTQjOvVjXVvrM5plvprVD7dY01CwyheeugMy5iwZxTyeBnnYUwhKGA3oK3kLzEdmyxdjRP8H/AVQ3CaOmNUOPN6PA6S49PJgCp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542490; c=relaxed/simple;
	bh=05TbWWxv3tntbUxViB7tGA8U0cvXI8ITITBDahJ1Ac0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXL33XsZ0mNbUGrrgZt1iliVYXw+HvWQ3zL83dwqDj9tBCdzkZayGp27hiNYoHG+Juj+Ih2i/cueFKe/I6+xMVARec/c33Qk3qox5aElhGfKpiuxlZk7L9042C6hIqU/DXCxc1O07I3jCj1oQ4E8HA8OHdBcTH6e7qYyQFu6tjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSFeXMHE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so46285365e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542487; x=1770147287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK5TGsJWU7nuB/Efm0pXlDktNbx5xUrIMoFBpRFKJCM=;
        b=iSFeXMHEhGdvaET7bjhMQPIYrA2Gz9AS+OcV7YK/L0wPBPEATr8UzPbzukxz+hLiUk
         xGn9LAegguUa29M+kOksXNIAc/6yHagr4SEFAcJqbJWNFXLttPKwrrSXbMbiCih6ZWBf
         TASsFs5cjvzb+GqHndjnE2wU+/3C7q8YWapHSM6nhhmBpN55Fm2ZeVG+zz3ZT10TAF5d
         amKuPWMJScIGZcsUN39WOTsQhgYls8gwWHxVzP9C+zfXmooDYkH6Lw1P2F79HRdmcVPj
         sXJ/HiWxeIshGvo0U8GcKgDzFprU95EFTFv3NURkWcKVZh8HOLy+xmpJUx7bTPuzbkB6
         wksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542487; x=1770147287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK5TGsJWU7nuB/Efm0pXlDktNbx5xUrIMoFBpRFKJCM=;
        b=q7SUQelALSIP3U5Fv108z/yLkNaoXm10pQY3tX+DND3kxXBKapT0h4TEOjnk11m2Ih
         gZw7q/RBaFQ+7OwGVy3lZc5D/S4Z8J1GIHYIXynuTHuRD3U6NZPfIJZQejJ7BwShkN9l
         rJg53BsWVUYdb3SHVFRiOPcVy5m/5PEYO+mQfLp/u5ECgIDxDDEzO1LquPewO9ToiAa2
         hZ9bkFYo05JTycj1h3+AYAbI4sl+Gf9GXY1comRulCnAf/UHFifETrpdPNbl1ubdRddF
         Jkq28eflfzaSWMtcOz5Q+zR/oAweTAIEQD7SD0jKRCsy+yLGnzV2hOlU/1JftEDIj5Ys
         gwKw==
X-Forwarded-Encrypted: i=1; AJvYcCV76018ODzlDmypP3mWCpks3BEg+nNlOglLbyIvZh4pBeCUEZjURcr0ICM+FKxCLueH6fxD5Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDz0Me+y98hzJokA5q9VCEJaZaGHwutiBK1kliby+e/C1IQ0eM
	gv+xAS+qEvSgLhxTfBH2Uiu2yNXDPxrEU8P7s2nV3w7X8yyf4o6mWrT+
X-Gm-Gg: AZuq6aL2C/fqi2WzhOTgizJBSDwLigAH7xfWYXyzOO52GbtlLVqEdg9mhrYV5lVwSYL
	ly+yPjKGTi34v6GXPXz13YJSMsUPNoUIk3cz+ZAXQL059a0rc+xgGjmnj79FCUD4PMoEJa6WX66
	iIoYtnZ41quocU1P+5YrUvsNSXOR1VLz0XJE/E/HNgjPGx2ktGeBpRo5MUfzKJWyjC7pPFC7iZE
	mkH1RsGuSV666d+vTLqQ9FKdlabfrppJOVfT//LV1ncAV1SjebijxZRtB1AqVpS/CkxM83Cwb69
	4mULhaMGGRJFX7doDXryKFdVSNigNg3IKJbQDeBJ6K9c00F4IO7Vft4J/GUz1+enxi4y21mZsYZ
	B9tLTayUDRrHeYQwLCyvn+MMROdBB+DZcxZEmm5q4DYrtL5rexv7i696WuMD60DYgR7F1gZd+2C
	xvQ+yZ1g==
X-Received: by 2002:a05:6000:184a:b0:435:975a:131c with SMTP id ffacd0b85a97d-435dd0b6b23mr3917733f8f.36.1769542486975;
        Tue, 27 Jan 2026 11:34:46 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfe7sm990496f8f.14.2026.01.27.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:34:46 -0800 (PST)
Date: Tue, 27 Jan 2026 19:34:44 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netconsole: selftests: Move netconsole
 selftests to separate target
Message-ID: <aXkS8b4vimfz9MvV@archlinux>
References: <20260124-netcons-selftest-target-v1-1-d3937f44c4c2@gmail.com>
 <aXdYwphLx2O-Hxis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdYwphLx2O-Hxis@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253993-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E47AE9A09B
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 04:10:18AM -0800, Breno Leitao wrote:
> 
> I don't think you need * here. The following might be enough.
> 
> 	F:   tools/testing/selftests/drivers/net/netconsole/
> 

Ack. I wasn't sure which form was preferable as I saw both being used. Will
send a v2 addressing this.

Thanks for the review!

-- 
Andre Carvalho

