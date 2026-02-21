Return-Path: <netdev+bounces-259814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL56GxE5mWk/RwMAu9opvQ
	(envelope-from <netdev+bounces-259814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 05:48:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D716C202
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 05:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623C5300BD89
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD90330642;
	Sat, 21 Feb 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T9iZDjeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747132FA14
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771649294; cv=none; b=ggWEN9+nAED9n8MP2741GjYeAX/eiRFVCBWX0rZAz+IvVBosjmUwrhd3HMmw+8SENq6Od6JF/20RTiaEHN0K+uHkgITcHxFHPI7kJf4R6XiECrTMugNBpNhO6UMvteeeV9siVBnQG6NUtqroNJu3hIbzhw2rR741AktoIj18mPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771649294; c=relaxed/simple;
	bh=mEsr6mMZj3A98YW1eNq3yyz90k9RElIecO1zjl+Pj1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJISx/1A0qkkrdhFpIFKaAMyBE3V8a+u94KerCzZT8NBLEyZ8aq/Q2NC1ATbvljMJzVMwy2XSJyk48+YDD/phSZQRDiVGRU4c/TeWlayXRQOjSn5TXUV9FtMJWCCpPEo/pVzt4oGY08WQvwCcnJQRMfU9naIy4jiJrIM7KDf37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T9iZDjeX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c70b5594f4so305781885a.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771649292; x=1772254092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eq3866hUg0iccmQvSfWEyoLr7h9wTLRxQOBYnSXIh+c=;
        b=T9iZDjeXJodH18Pg6Tlptd03tg7yvB6qXtRgYz6yI5fts3rgYz6AoTZIwtpZc5r73b
         nyhql7BjoxqPiCU+yzn+VQ7eW/KlSh6xNO3BWpGEcShMvFIu+R/u+68vm9MkVkLt+B+f
         NpLLJy/a30t1qo0YiyLOQdyTA+geMcAT3a8H8k+1w9FXPW5MKNjybmpZayvimzAT6sOf
         XHwg8QpRIqJY9etOCNNiT5bc/782nqG2RTniU7HwvysJtvUIOIAHGZlV+Ugr5KZmp4XA
         bv+fCmFcy8NTO4szx5uo9tLLgmBtJxTXz7dUMwSwgkEo/M+WOwN4T7oxbmRy70oYWQSA
         VVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771649292; x=1772254092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq3866hUg0iccmQvSfWEyoLr7h9wTLRxQOBYnSXIh+c=;
        b=wCcgWdrhh+o1YLgVX7Hw8stSf2aeLE3I6JGy7KgciUJNmrWqia6zPTmjNHiWXNfygH
         FqzH1ln587eTRmJXusimP/HaTFb1nquGRP1/Y0GvcKRe7tTLgTRqhc6X4CIl78HSOiOs
         RcqXIorauBAH4mfgTcBR7gOnan92yrMFUxb0wTt8FJe/HdeXl4KbbNMsKz3IzmYTSHID
         ybX0w2dEjH95/DEKbYQ70pMS16rR9Q4QThoIHnfIYq3Sqn9G+bkRSAjvPcvIh3PIA40t
         yt8FRgl5dgBwU1l8UvFUlhDixY31J379lAiaQlSTGk4XHMwsZcG3wbs7/R9IgEcg2+uq
         Z5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV9I6Eu4j2xaCw0q0bMox2gnYAjYccV2cGTkoDAZjjF17wQhzM8tx34W9li6MntldrCzJPUe1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSAnZrL08pu04aUPCiUZdlaIVKZyaDExj1ou91wPmFiSnlbco
	stsSInNG3e/CCNC/zaObcE0lNMh+sDY4CHcypLm3X+JVg/L6KeLSsiCewoy4oSD5e9I=
X-Gm-Gg: AZuq6aLjwucQ0RlFaiXHfGI+Zb7/7/pQril0nuqvbfItLtFWJhkuv1TW9CNrJCmqOSu
	PWm4cm69PgZwH3hFUJIu0LLsU1eACxmjdf5fYIF2gtmuTPPm0tNTe+Qfzm9aQfgae08s48br0xs
	81wLP5OI3CiPzs2Uy/SfUOoaPKoR0pYvqIX17Tft2kK2zK+fv84k3a7CeuaOYQvA9oFljOyjJji
	CQJHrfS0MvtUe/0gOHSQRhpa/OpmvyvcNjKOVQcx9yqf7hOm1lVQOW4iqpag0U5g1mDufT+15rz
	AHGOuMNae9zaI5w8AXiDJBC+DBDkqa3nPFUauwlWkiJv9mRJCbNRdVutRLbL/ZCBMWVl104s6bF
	w5tY5LIucHe2+NRst08QKlZbRAc+44z1InSEqlq1mhMLF7/B1TJoM0RpMPyfAJO3Tng9NgeOBXH
	T2IZD7SudeTdOP01HI/o5bc/9rq+TXA5rHeEcPoKLfAXPTDmWlSaPXudH3ReXNynE/Y6OkqV73b
	UF8r/bZ4A==
X-Received: by 2002:a05:620a:8d1:b0:8c9:eee0:dbb7 with SMTP id af79cd13be357-8cb7bfc8d44mr724210585a.23.1771649292241;
        Fri, 20 Feb 2026 20:48:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1202e2sm116505085a.44.2026.02.20.20.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 20:48:11 -0800 (PST)
Date: Fri, 20 Feb 2026 23:48:09 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v23 10/22] cxl: Export function for unwinding cxl by
 accelerators
Message-ID: <aZk5CVRELS2qo92c@gourry-fedora-PF4VCD3F>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-259814-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: B03D716C202
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 03:54:26PM +0000, alejandro.lucero-palau@amd.com wrote:
> -static void unregister_region(void *_cxlr)
> +void cxl_unregister_region(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> @@ -2457,6 +2456,14 @@ static void unregister_region(void *_cxlr)
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
> +

kreview suggested you probably want this:

void cxl_destroy_region(struct cxl_region *cxlr)
{
	struct cxl_port *port = cxlrd_to_port(cxlr->cxlrd);

	devm_release_action(port->uport_dev, __unregister_region, cxlr);
}
EXPORT_SYMBOL_NS_GPL(cxl_destroy_region, "CXL");


During testing I experienced some double-releases when doing aggressive
loads and unloads of some drivers.  This was one of the fixes.

~Gregory

