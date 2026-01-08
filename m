Return-Path: <netdev+bounces-248292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1C5D0692D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 00:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE243301D9E6
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 23:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9777231A571;
	Thu,  8 Jan 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYFa59w0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcO30Oa6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847B1A23A4
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916416; cv=none; b=rtcR5wyANSG6ZFYBPeofvw8elxPlwYi6A0aBJ/RYHgih6q54nxK0p8NBj6NSH7ygD8ZlJiAtap9J1BC4+wwA5QgavbrL9B8g0i3hgsH2z7Cjmf02R86oHqglY6a0sZwBC7+OQ/Z6fGknlKa0ldVa4i2Hh1W4DcHngjTrYmQuPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916416; c=relaxed/simple;
	bh=Ws5S9oazky2bBHe3gdkE4OmsYjXoHS0fZf2fCk0+CMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJu1YqhlCy8WRpgQcJsEwOHrUCkzRj0KcHZpCnbGQcFIiRi6vn5TQP8A+YXNEI0D0GOePXEnZyuAwfZi+/q2RGzyOIaPTlGNpLqYHg9pTIbjxzfhiynVYdTh0Di5NyqaeD2++PAELVv1WXbEshaAuE5xfE/8d26Q6Bl3ZUCRAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYFa59w0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcO30Oa6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767916414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvaLn6viyg9kXapGmyY93KyT45eozmIZAkWSd+113fM=;
	b=WYFa59w0oWHFxqNfgE/rJLPrIgW+5y93uXIHD81BS1mewoihkyIKiz1HTZmSUsJVuu/Fh9
	vJkmI6dGy2zrdPTVtre8iLAYfFOEKRNmyy0tiUpkJ7CSYD2rzMJDcsV6Rp8xqq6vHmh7JK
	5KhGFcXWIDz5p4U6H8bx7rYkDp3MbSo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-omQp4VQyPhmckVUpi9uEJQ-1; Thu, 08 Jan 2026 18:53:33 -0500
X-MC-Unique: omQp4VQyPhmckVUpi9uEJQ-1
X-Mimecast-MFC-AGG-ID: omQp4VQyPhmckVUpi9uEJQ_1767916412
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2f0be2cf0so694918785a.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767916412; x=1768521212; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvaLn6viyg9kXapGmyY93KyT45eozmIZAkWSd+113fM=;
        b=BcO30Oa68DA1G/5jgzSFADUuw5mSS898qN5tKmuwNbhnIKpy8ay4tDCcipZIcf9yj9
         U7YjQT6mROhz7T4JK3dQZytpB3txeSVgVsYw15HyE7JOvh8ZF01BpIq5BHuUGtzB3rFV
         /9Uad/kwTj4euLwn0QTJOkbCE8Hz7bCRawQM2tDQ83f5Y51wLhGg+NLrnp/LE5qWKexm
         HYUpoUBKe/bKyK70dSeDQaEQosh6KEmPZ47R/sUgyACcilrB2U6kd+pBML4yChkY8TXD
         gSeLV33k63EekvPBWEwf59BVX8vbP1KbyNRcgzJOsQbfxWGl7IyrDXtm2fkd1ypa4SHl
         9MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767916412; x=1768521212;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GvaLn6viyg9kXapGmyY93KyT45eozmIZAkWSd+113fM=;
        b=ljzPD0O/qpJqI28SNt9pSDzcdhdH8ev4lgQ7dNK86lgQNj1RplefNxO9zw1Jsk9O3G
         gPql6RtSt3YHdXxKdabMQDZyEx0o45FgIDj4vsCzTXdo+b+TizsWWZK9HOblkgcEES2x
         436cGS3X14xp3phgmAs4uLIuVCRQuDOUpM0Nds4EgUgMlyazWWhRpeOO7cw7lRoKHtY+
         ZSokpwVgi1vTkyyUGdkdfTqaA6BgUHngoVAhi/611SCHHr5hD2ZkhZFz1uBymTvbi64C
         fnjt7jKE2WwqEfNM/M/au4vFG1zy3ISndFq9nKRgtALpCTPqCDmGrkJAkjehhDiZkQYi
         //bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNpBeormsWwZWMeGHxDeuQmEMBiqAbNCF1Ly4jBu/oNtSvnKflskzZtxrLi7GLQiVgUFfUSFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsytdVXcbdyHR3DU6kuJAbkThwEGDHZlT+ImI5YJjPxnSHw0W
	KzWcn3yiym2EOjdTqpE37/XwsCp8NNe5JoWi4JRtS5HR2kuU2mzsqUUS8ZzyziwswCU2e+PfGWN
	9AyqPNldM6lCT4Pauu7rwiWz51xc/OzpULnh49b5jB7CXk+A7WKrB6cVCuw==
X-Gm-Gg: AY/fxX4hHy0xsmri7e1uO/q3I9gCbdWQoyUyyL3FcL1N81RPYtf1nRrivtBocmuNDap
	QVROYZfByP5P2QI+DJNJkfjS6wX1rG49Q0a0+L6kf6VKs4LKaJe8BxCG4qwnchw8oect/Cg6nP7
	pdk8V2yNZdSj25Vfz3T/v34z2YNXCMeYy4mVhoy6Se/EQ0NwT2fFLUDpj6vaGJaGYsznIlEC8jO
	BSOpFhTlJCMsTVpVkOkYcxPr4SgX9JCFhuj8ZFwJcooSOLuPPAhbB/ErBGh+Wx0NcBnm6entGD7
	aDfZld8fUWItBm342SR0bDPpyfY3yDeVDPfv93JwuSAKeKcj3fNMKWs1Ir9Sm9u4itfUhJ+QUDz
	Ik4y+XvI=
X-Received: by 2002:a05:620a:294a:b0:8b2:e638:7dce with SMTP id af79cd13be357-8c389419060mr1129792285a.75.1767916412583;
        Thu, 08 Jan 2026 15:53:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4aSIvh5903rUXtL5jEtQ1zOb6hKj/5LGmrWgk9wivP+NEURpK64IiEcwSkjpWLrpqPNhyVg==
X-Received: by 2002:a05:620a:294a:b0:8b2:e638:7dce with SMTP id af79cd13be357-8c389419060mr1129788885a.75.1767916412239;
        Thu, 08 Jan 2026 15:53:32 -0800 (PST)
Received: from redhat.com ([2600:382:850d:c75b:2aa0:b08c:d81b:f52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b8b21sm677303285a.16.2026.01.08.15.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 15:53:31 -0800 (PST)
Date: Thu, 8 Jan 2026 18:53:28 -0500
From: Brian Masney <bmasney@redhat.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	sean.anderson@linux.dev, linux@armlinux.org.uk,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] clk: Add devm_clk_bulk_get_optional_enable()
 helper
Message-ID: <aWBDeO1KJ__eGa1M@redhat.com>
References: <20260102085454.3439195-1-suraj.gupta2@amd.com>
 <20260102085454.3439195-2-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102085454.3439195-2-suraj.gupta2@amd.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Jan 02, 2026 at 02:24:53PM +0530, Suraj Gupta wrote:
> Add a new managed clock framework helper function that combines getting
> optional bulk clocks and enabling them in a single operation.
> 
> The devm_clk_bulk_get_optional_enable() function simplifies the common
> pattern where drivers need to get optional bulk clocks, prepare and enable
> them, and have them automatically disabled/unprepared and freed when the
> device is unbound.
> 
> This new API follows the established pattern of
> devm_clk_bulk_get_all_enabled() and reduces boilerplate code in drivers
> that manage multiple optional clocks.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


