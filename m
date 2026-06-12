Return-Path: <netdev+bounces-298677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 84LhHQoOLGr5KQQAu9opvQ
	(envelope-from <netdev+bounces-298677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:47:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B9679F50
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:47:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Rrjfo+Kt;
	dkim=pass header.d=redhat.com header.s=google header.b=mfI+xVxp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298677-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298677-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97EF63000BB6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616EB314A9E;
	Fri, 12 Jun 2026 13:47:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4953090D5
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:47:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272068; cv=none; b=b1bzVdHbXZIEpH8jtwYiyt9P7PWWqzQ5AKH+OyJDsgiJTIHWON6RATXbOXH5dLMLceXEKkHUyu+r3lRrK1YiZUOu64XLvXVb2O0xgfYRRCLZyfXbt6y/U6F9A7YuZwBwA7W49dGn+yKTiJ07mOTvjmpOjkWV2tv4hDeFKrTXyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272068; c=relaxed/simple;
	bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiv5eVHEhKz/prYv4U/oAm1tybdUPqEx242CpKYoKz3iSbCBqMxQbK5PwlnNwLE+UkfJWJTwBhQs8SqoWFHatlh5g9EWXhgxjlif0IWp/crA6jLvi6C6LBiF/VVf6KWNn0stm6hjaY8Fr3SVfzv8jqcFNfY+xz5WfU7aYJk2cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rrjfo+Kt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mfI+xVxp; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781272065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
	b=Rrjfo+Kt+Kl4f726hZ4jahXCZso7LaTLDRzUb2SdBCktsBiPvNhyA/wjEuGWfZcBC9xPDg
	sSC05kTcFN/FT9Ye94OX5cUQEVGaBedaxHsNXBkB23VSv1PeuYYlkS0A6rDKrolJmiP9PF
	TzZ+4i7aQJA/4hYSXdGj1zI1ykN05Ns=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-VoghhYC8NK6-RyAaEWotbA-1; Fri, 12 Jun 2026 09:47:44 -0400
X-MC-Unique: VoghhYC8NK6-RyAaEWotbA-1
X-Mimecast-MFC-AGG-ID: VoghhYC8NK6-RyAaEWotbA_1781272063
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef66cc579so461734f8f.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781272063; x=1781876863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
        b=mfI+xVxp3WXI08A5Zabgyv2RlukW/Kwn4dTkDBSn4YZhEoNPWasAZYUE3U4u4tthzI
         q4UgwGI9+mD/N5mYigT2H27Nd6nQDr6m8gn33+PgDYcvLWyIPQz4ZC6YrfuXlJSPCRUX
         BW7AgXJ9Mq+fBKK61raaS1UhRDt+QL8zjuZLbW4No/lm2JCk4R6FCnL7C2fI69C90N1B
         +ExRSDTGe5aWIR+b9roDmlDZe++Z0eJHheXXxfZi86fe5N+QPuOqcqc7RUwjkmjs9l+Z
         5PTKdQ8QpwGnedp+W2shxxwTz9IqS9MnJXcOSPxs0RNZYgtnRR43PfmSGuJphvWvAIaF
         5q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272063; x=1781876863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
        b=jWnCGSjzJm0vZMqMDbPmLmP8x7VN1xNzBAQY0X359Mw7tysbhvIVs2H2mQEfOdLKxA
         Aburxh8ZsRghtn+iT4TBDQuBh5qLkCIzeWnYvKiUcJtKCRR+DCuKQQ5uPBdP4qm+7F4x
         lEJ/+IMZ/07eQPNLodvQLSbQEOuMEj74ngl/cXDeZu1TIOAmJJmo1gcBShhDKaMsN6Np
         gPnMlhbAnMrSDCXoE/R5b9Ag3qmeuXnbrgzvwwMawfDNe2V4PNRDwFmKKw2vax7i0WZA
         bFnwQblgKJlqrCTBQLq4/1bZ55OjqgQJDprcwRxXYtOCcJGVaQxlXfOstIfWExluR+CR
         8vZg==
X-Gm-Message-State: AOJu0YzB5Ayqc6TY/C3Xrwus08S7clHbxcvPGFT083/kjyMsnW9GBozj
	biWTIx+OR2I6QJXh490IMmC60t++ElTZ34CLT8v28zB2TzFcVAh5rAYwr1kgrv4+knqKPskxxTq
	96uSaN7GJwWsb/4xoAfH9prQfEpmcom6s66v3QNvhxhybabUUSjbRPtUMZw==
X-Gm-Gg: Acq92OE4X0f1+aQdjknfqJHLSfunAORrtOIe4i9dYXOG4XXvhzHBtQfhU0JCeFvGZje
	RZF/bPkQaVsRPErfUepkvhfnB+Om0tWAbbkPiHBjUYj9AWVpvqqZuHmpHao/Td4fNSi68we4kDP
	nh85nI2SIBHve5YNazdTu5UCJ3TURIOMAyr8/Hkjw8D9BtOufzI0VrQiCeuRxfO2teAliaM8abm
	DlvzBHIdkHROWYJjtiFXWGSo1scai+Jst1vY2jfFpu8pLePjJT62/KBFqXxqhFMHX2PWDHFFhxf
	1KRSjB7rM+8C7dVhUGABgFgbhAYnI1tweqmwl5iXPF1b+EWWrO8F60kgP//5mNVHy3JTX1gwSNt
	CN39fkYkXolrXUGrUmCcaQdF+DTkMay2TkaY937WeX1MbiB8WEgkvynu29Y0=
X-Received: by 2002:a05:6000:2982:20b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-4606db98392mr3413024f8f.27.1781272062831;
        Fri, 12 Jun 2026 06:47:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2982:20b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-4606db98392mr3412986f8f.27.1781272062395;
        Fri, 12 Jun 2026 06:47:42 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm5879863f8f.13.2026.06.12.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:47:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:47:39 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aiwN7Uf7X5lMQurn@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-5-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-5-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,leonardi-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 727B9679F50

On Fri, Jun 12, 2026 at 04:52:16AM +0000, Raf Dickson wrote:
>Callers of vsock_remove_pending() must also call sk_acceptq_removed()
>to keep sk_ack_backlog consistent. Move the call into
>vsock_remove_pending() itself to make it automatic and prevent future
>callers from forgetting it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


