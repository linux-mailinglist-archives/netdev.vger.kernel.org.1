Return-Path: <netdev+bounces-243970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7CCABCE1
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 03:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4820F3004781
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 02:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED5256C8D;
	Mon,  8 Dec 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UgAG7Hdx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F7264A9D
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159704; cv=none; b=CH+k56Twqso87+fMLmDOsG36eA1LMXoeJ3U/TJ0AKvDDoX1cKiCs4ikzoHsA2+WcxTuF07erQ8a6HAIgWALBmallCjEMBAKQ+vTX4hYMssOm/jonFuuUmgBAYl30nnReIpsk7eR9+XsS7tYMAnISaVAWXtSiPxSZpXPxxvuja0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159704; c=relaxed/simple;
	bh=YvaxHtspKDgGP89dgp8WLsgmB7jhldyXoyX4PG7HjWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA1nZslGqkgOVf+c0+sNu61e8GrD7coz4K0aqJzWmxoBsr9l305+/X4Ka+QkL/LT+nSMWbYfH8aj0mnEVFZ7WBJ0XqguvTUR4Ak9tXlKeECOcPACxrv/LfURp6X/SJtHrmG51HE2vNr78uUFppCUJF541w06yd8NywH8+1be7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UgAG7Hdx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 182C83F1F0
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 02:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765159692;
	bh=YvaxHtspKDgGP89dgp8WLsgmB7jhldyXoyX4PG7HjWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=UgAG7HdxwWkQseIMkCgWd+Q6rcow2HWilDikUovLH2FWvTIAxbI8IpZ1TFYh8eFM4
	 S4slYYkv/SdqwTWHIYkQwa9SZyoslpAa62N2xUucWQyNKmLHIabbocYYZvWpMjTEyf
	 Qe4BDDKohgJyvlzvjeuO5DGeRE6xMsyRXv93yv6zUelyxmWUWLkF+uN71QoyvAEcyD
	 tswIdO3ylWSgK/wJMeDAyWmrEoWylBIZby4qrkZXD7kd5U1g67ViotUkNKd7U2j2Os
	 vtg/qRROu76caRD5fxCUnLWeB8GoeDmqkcwKQSAIpj+nL7md1LbmujHAMsNGlsAs2Y
	 daEh2S74fMycfpDukNOwp4EkE8yIqayOAPbcR+x0I+QCEHVs29kRnnaTe5BkQY0t3X
	 6z8FN0t1IQZFhJj0t+aZvKGc8Q67gYay6dPBDZ//xGTpyhI98ezMh+xWXEkagPdgDP
	 FK0M23W01LOyUr22bCp12dzhcLjKg72wD7Huw9+dfGawezxAJJEoHruLHLGY+oeSlf
	 P2BYK4/xC39adcH/TQt9Y+lcv97u7u4+kWl0x4wsbDD0ug2hVJ7Co+5u5L1GQwBZ9Z
	 da62L3bpWp4naBCYBJpxuOnFq7q3VO+Q2FB/PKTK38xoiW+SxbUS+Uf0o7Kb1eKmMq
	 LdgiONIvg1ZVvxsNNojcL+bo=
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so6756602a12.0
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 18:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159690; x=1765764490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvaxHtspKDgGP89dgp8WLsgmB7jhldyXoyX4PG7HjWg=;
        b=HAfCJiTjeZSXY1pY2Ygk+1FdrOHdytiLb2pe1DgByVUPGD9YsYVft/CQAN7EKi+E1T
         jfh2hTSsy2jf68teLAex5Q5U8Nf7BeBp3dBok+tGncpLU18BbgZ7XWDRgUYs5Mlhcryo
         Xwr+tgT/V1w5l+dhharzXdofO+UMTj6D5P2hDU9uJpM8XZk8SalNe9j7kNubqvl9MFDy
         u08YP5IDz38ZPVEt+GEJiuIRaIkgbORTfHbxU2fh9aEeCbAAHMNkM8T7y/j6PaPL9XnX
         IKRkELEZq0Bkoof6X7Nbr8dc1iOtx6NbcxI3MNu63AnW4bhvm87y6/kPeqDOCPfADMNI
         UlOA==
X-Forwarded-Encrypted: i=1; AJvYcCWqR+xXHZSyfG2Pn3Fu9JW9LTbcwXHMX0RufRpRFLnKrhzKNF5Arj1bflP/raZyL2+MGsn81tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50XpiUfEsNcbU/0Oy4R5qlyXZ2l63APasWFEtt/YceAMWENN7
	FJkN5LbRx1H//EESLYoJ8a4Urnzky4QHG9ejC/xflL/0Z2f9lK90hsajLtp8mokpaCqB5C7TMKh
	zhVouE9s8+ViARYD/dZXxLef/ZK8pF789yHQe8a9CpAarFVPBHUJlM+xahCKiVoYXxHFHF0lnBh
	koz4UAo0sjjOxmLdfhmQ8BFMHjb4gdg8tdr4iQEjJ0v3XUPqq5
X-Gm-Gg: ASbGnctSsM1nb9xN3KyOBl7FIiIS+OVdgc04xb9y7VJ6UObU1+q/X+kzEdp/HQ2e9IN
	U4gmVyUVKYRQnEa5J6U1tMZArtcrK5QbpMRkDFPYBOjHaNSV6CMh1xl4n/g5BYYNIH2AR5wQ2/8
	1LCv/FtaZ2LhELCK1nlm6gHjpzRiBJg5r0Vmp+sL02LVjRgz4uBsYuzA5DImxpCtVNYw8=
X-Received: by 2002:a05:7022:493:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-11e0310f71cmr5415103c88.0.1765159690128;
        Sun, 07 Dec 2025 18:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp69C5bU55mcpJen9vbrbnGd0qeI5z5AXJUcTCrX9qLG+52iEleATqKQsNYar5yV0d75Ix4tWv1jDJrED771c=
X-Received: by 2002:a05:7022:493:b0:11a:2f10:fa46 with SMTP id
 a92af1059eb24-11e0310f71cmr5415092c88.0.1765159689746; Sun, 07 Dec 2025
 18:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205082459.1586143-1-aaron.ma@canonical.com> <aTL2GcF6CTXRU5Wt@horms.kernel.org>
In-Reply-To: <aTL2GcF6CTXRU5Wt@horms.kernel.org>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Mon, 8 Dec 2025 10:07:58 +0800
X-Gm-Features: AQt7F2pi71plrHHekMBysUBnP2iTaJL6T7l11RLt0u5pBbsJa8laRZGcz_outWg
Message-ID: <CAJ6xRxX3=1f9WMFdAs8-dU8_AvtTv+RDxpL5B16KJTCe0EO4nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 11:11=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Dec 05, 2025 at 04:24:58PM +0800, Aaron Ma wrote:
> > Add NULL pointer checks in ice_vsi_set_napi_queues() to prevent crashes
> > during resume from suspend when rings[q_idx]->q_vector is NULL.
>
> Hi Aaron,
>
> This is not a review. But a request for the future:
> please don't post revised patchsets to netdev more than once every 24h.
>
> Reasons for this include: allowing allow time for review; and reducing
> load on shared CI infrastructure.
>
> Link: https://docs.kernel.org/process/maintainer-netdev.html
>

Thanks, and I will keep it in mind.
Aaron

> Thanks!

