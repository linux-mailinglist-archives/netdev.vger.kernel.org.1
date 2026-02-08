Return-Path: <netdev+bounces-257854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P+7LNvHHiGk4wAQAu9opvQ
	(envelope-from <netdev+bounces-257854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 18:29:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228861098EF
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 18:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D7EB300D956
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4422D7DE4;
	Sun,  8 Feb 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpQA5g4a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZrdA/s7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E52D7D2E
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571756; cv=none; b=X03IEJk+KnUJF9RJ9dAQ55uChVDwcnih4i9x7JvGAP2FfSxZS+pT8o16v3weGUOsBI9VrsGeGM8NHkRi9UbdS+BFHqChWJ5PBjC3pa7xa4cY+xqk65W/knoV8sGanI0pKEiezeD2+zylRGan56m+4oyDG8m1ytwAeMLkcVNTreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571756; c=relaxed/simple;
	bh=Io+4WSWRnqj1lMbCNwmQ7f4A9LlUapVwpGpfF0Tsf7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNIm3nlLsAKPX7D84jac+eHQBPRd07yQERHMTu4efyjAtjWwkJBWkUN4p4k8nbIjWYJUltWAzKejHcOXy/EA9gjYCvNKkLerMzjp/AIo+RJqWW625IcvpRlWueE2rXoZOv8YjKxyi73P7iGjtSOabfCfcGpW2eWKo0IKhvFxRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpQA5g4a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZrdA/s7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770571755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nb+Zr3iAkeociuNjy7qiEZVe03m0xJIJkKHbH7Kn+gY=;
	b=DpQA5g4aJNPFWudtf10+MGNKAGhR+UFDbrf5HPpfZbiAP4VMGb7vuW3fGrzJLqjKeLcU3P
	aHdKOhSooMb4zWd4snxeYQZ7eL1PyqDa7Ghpuk4hkOT54y7yWO36yakqn4Cys0FknNmivn
	Gia7q+eCvIgGqiRgKEJ/p17McYP0Bfk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-TklPEm6OO32lnRGNLoK3yg-1; Sun, 08 Feb 2026 12:29:14 -0500
X-MC-Unique: TklPEm6OO32lnRGNLoK3yg-1
X-Mimecast-MFC-AGG-ID: TklPEm6OO32lnRGNLoK3yg_1770571753
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48069a43217so25627855e9.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 09:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770571753; x=1771176553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nb+Zr3iAkeociuNjy7qiEZVe03m0xJIJkKHbH7Kn+gY=;
        b=KZrdA/s79G8wJqjlxfwYDVIgoCE3e0t+cKHB1RFN6CU3vaLCFUJH3Ij2MRt9iGykvv
         4tL5HBtWzW/iPWsY9mPDQkxnyIMxTqLazavLqZAwkHU2Gw0k9RF7+5yO2OpIF2eoagjw
         QLfe34psSiGxEesb5w55EBFSiepofI63rRBERiZjMNHURBHVGJtM2YfLlxZWM7rc3sHK
         Mtv1UA3EYhsZ+2jNAklRBayl+OBPks79GUkYKo6/G4wYeF/SwhZK7sHEj2xBMPGjDYPg
         CDavUneycZbuUKlnF6FixU+wost5V9EBfO3H0HnL7uduQ/En3yqHFoFlZWJ1VkA1O8xG
         8ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770571753; x=1771176553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb+Zr3iAkeociuNjy7qiEZVe03m0xJIJkKHbH7Kn+gY=;
        b=lfnWkYdvBD3vjMBZH86OcCpgIJGPSqB9fwWFi7Jr96mumExeTPpS5IG2ZVvm1PeZ50
         cc+YgA7XGcY1fnrkbg2sHfx+9iN/l2RBwzv3OWS51POrh+aLExLIm/aBb00TJcqu5yU8
         36xYinCV8f0J+eLbTjVrk8vKpAKy/BkuB+9OupUnb+YdrS1nwoFw53d2+zozZQ0Hi4IX
         v0mMURL+g49fYclynUEBfSvRkJCj1pzXbl+XiEySZon5TZASXdd08Xx5SkYjxXTMdZSV
         yxjZ5U7FqkORnEuojCt3jh541dED6/GUD7QPWVnNeFY0Xrz3Ic+7y97eiwSGnv0qUupm
         m9lg==
X-Gm-Message-State: AOJu0Yxe7cgfjdC1VDHA7zBCiqxUb7pAyX+j1dXeuUFIK/9tnP4YgVwm
	EkHwjG4iqFJv8QkgHY+8epvwGh5fPinW+AyfY8d+CC21vizub1HiF9wF+gazJYyCZ3S3ecd/m9Y
	EhpL3MtyKk0WPgWxJ/HSnncS6yGlqQTTqWjP1MY9i0N6Fe44CCFKc/P2pPA==
X-Gm-Gg: AZuq6aKous6NwBCzd/XlZxwfc2A7lON2ujVn348Cz6UfKTOMYHd6wT52MUm/hHy7kRz
	ZOn9020qZQF6Ub4dJGTnlz/agEarPQojzgAEsgDfgNrfA+Nl5lbgpyHO9AN1pxNRA1pVS4vBbz7
	MSIXvRdyvjG9Ko1xqY58gTJT2bQlV0EiXPgJl7rv70JLmCejw5Or9z/fqwwiXKXconCt/m5zQ4h
	B/R3ufbFojdBsmAJU0Q5ibIIp5f2nmPwsA3VBg8qlhPLYPnmJHpISCOQ5Ng52ztKwmrsc1zoP3s
	JOY0CspHUe2Z98FYODC+JuAS70IYn5/Eh4DjXVBSsAAc/gks6JCk9thZ9e2A1r7MKjsITANCHB5
	D+pqudLxonc9u6sIpVnbwufBTVCGWdBVaeQ==
X-Received: by 2002:a5d:5e01:0:b0:436:23a2:5e32 with SMTP id ffacd0b85a97d-4362938a46bmr13192766f8f.48.1770571752887;
        Sun, 08 Feb 2026 09:29:12 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:436:23a2:5e32 with SMTP id ffacd0b85a97d-4362938a46bmr13192736f8f.48.1770571752473;
        Sun, 08 Feb 2026 09:29:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376b62b835sm5674343f8f.12.2026.02.08.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:29:12 -0800 (PST)
Date: Sun, 8 Feb 2026 12:29:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20260208122325-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-6-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-257854-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 228861098EF
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:47:00PM -0600, Daniel Jurgens wrote:
> 
> v19:
>     - Fixed ;; and incorrect plural in comment. AI
> 
> v20:
>     - include uapi/linux/stddef.h for __counted_by. AI

this is one where AI wasn't at all helpful.

__counted_by is in linux/compiler_types.h


-- 
MST


