Return-Path: <netdev+bounces-259489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Il6OeAfl2nvuwIAu9opvQ
	(envelope-from <netdev+bounces-259489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:36:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB115F968
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594E4304A59A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090033F8DA;
	Thu, 19 Feb 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhmKXNwh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiX+ROzB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FC1F30A4
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511719; cv=pass; b=NYL04TH6JnzyqnEDzrMMFeS+IZ7Nwq+/3gHfh263cgD2Jhvy53hM3goGNjKGHIjslhfOrv4SLFRoGb6prvzWU1dGa0WOdOf9wIiR8204sY3jyHbVMN/M9MALnxZzqPrLeSTkrnPRBF6Kpgl9wBeTI24cKvU5EFvnpunkAyfsOKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511719; c=relaxed/simple;
	bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IBStbk1hf0ihRtZGaU0Gy6+HlR7iaUU4I3+7CzHm/ueqfJkqczPpAe7J4mGGEs9QicNsbtf5C31oOzrKBG+nd8A3BsTNMcUO1SI+f/KS+3qXWbvGNzz2x6mpJBG6K5c7QI/tFMGypBCxYwUoe6KCzGUzTeQNQ5SFfve44UpNp2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhmKXNwh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiX+ROzB; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771511717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
	b=ZhmKXNwhS1ngFjdKV58F2kIrxQjIrwdqkras8mNLtB75O3kD+fmmA0NVLYS1k/YXFOGnre
	Az9SQ/G0hP6oJmJxUq0kovKqV1mN484z1hIJNmBTG9HX54XqhDibWljIoCL9OGuZRjwMyl
	Gio8MM3vlxOdrB88G/2P0r1aUPeUP1k=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314--t9OcWhvMKGxRfIOcnQCJA-1; Thu, 19 Feb 2026 09:35:16 -0500
X-MC-Unique: -t9OcWhvMKGxRfIOcnQCJA-1
X-Mimecast-MFC-AGG-ID: -t9OcWhvMKGxRfIOcnQCJA_1771511715
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794c39ea759so15970127b3.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 06:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771511715; cv=none;
        d=google.com; s=arc-20240605;
        b=BHFw8Bvsvg5J6Q8GKeLhNE59HHs2lqptNMi3nnognd0vvVBQ8SHZSaTbEtJWTnYXrX
         60uk0qr+GIje/UEDLU97Sh9ZAGq8qDQoNuon1rs+jUdrN+x/BzSPprmC74Fwb1FoztN5
         fAIMa3XRNmpldbBUjMv0CPKyd7nQJdtoq3Ojy86/7VsuZjbS7HXj9NFkLaUJKOspJiuE
         uG68uBCAK11cKXy38i2j5Bw4rGY53oEzAcxWkT/Otxz27UVhrcgtvUh6uC0K4FNq9wqR
         xveNyGlS355gQkvpoNAiFp5JpgM2kDFb8nSwZHYNFEx9S4y2hB+9hI42qJ68airTfL3x
         D1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
        fh=Wg/vdzmmcv0bdokXDj01rdr1dq0ps0hDdV3G1XSos+U=;
        b=dDQOCf4UT32DBMivxp5bCTp18vPjP0lJm/TdgMFeQyfY90Uopg518+6vIvBMj8P/YX
         YqTS2HLeTDIjp5PUYsR0BCkkV9xRn052Fn2ewMrHDsNBJycRtSIJOS04gVz4+JLc7mbx
         493IdGsNjEIAfPGA+IYny2PaFTkFuEM+UKRWxurlgszcRVSd8IifsbkqZjPigwBiZsdE
         8I7ymxamHa/K6ifWFRV/l/oo4sPQonjaircnchlaSIh5WjFgk0MzJEJEyWkldJfi73WW
         frCJObAvZQUIbwPB3DamDkWgnY/r37H6iLLElUSHZ26JM3YRTBttzE4SfF7PqdssOQ2t
         ydKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771511715; x=1772116515; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
        b=LiX+ROzBg8v68XYnnmkKEkgos2FcChDT3BI687HpMANuVWpM2WvCIZoG4X5O3iF+aW
         bggjw8KIGKXc2PavzBrE0I7aRnVxiU/LCfTbqudbsogPuPXrfpv+kHQcSn3XGjaKpmZk
         9ArhzZ76cuw4U6mPHgUpMO+b/eRelXOGQgDqqZ3JVyOQmCp1ciFdv7Y/an6YcJc3GBbQ
         HcYsCCOf+TYVlN+SxlA524CTRybrff7lSYA9Gb8vz5klUwJUbeXASF057D+v8T53jJth
         Bo6gZKEdj1NbpCnQ3to8iKm/oc9hC9i+uW+BWpZ5cFECJ3I0SY2cX9eEUXi7ikqe66U9
         Lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511715; x=1772116515;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
        b=OggTk5SUkhbqZAeJofaCJBGktp/7I2AMXIzrIieFHCoXzTW1/DtBAZXBFRcwEigz6J
         zvAVPy2sGM7sYzyuRQMTAsRELnSBYE3IFz3UU0FIFMVljkwTEPwDermeQxRmbpbuxlJh
         JKIqFjD0b6GTFjKXO27m3nX9DyEu4rM6IRx0xLuW5nSN6WYFlpkLcUZHSfVqyXWIPjus
         22JElzLC2ONwpte5T6KX17FutLKlaCvFzgLa2VS0741jMYQlxjvnZ+hddOjqPok5LPcW
         UTdQW9MpIT2bgFjCGc3DOuisx71RKs+RinzcAPzgoX3EuVMH3+sqkV68+G/wvskYRVDT
         E2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnhYQQCVDapx6i6Kv2HrCcvrcc9kBM/gEB47KGm2wMLmZXABf+RJAaBHgVLaO1tqDlD6dJzJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0v8iL92B7CanmhQ8ifss1lknOv8q2AHBj1vxHZVIhtRuP02v
	y/dTK4Xlj6m/G00d3ywPIYUB4prnd7Kx+K/EuDa/jIjRP0QhPTizITNJS+X7BtEB5em0BzQ/ueJ
	2+Thkh58u6eMUn3zvmkQmd7iAI6Ap+gNhZ3HSdrdVtGVAY5L54AccHvGkAd0By/MogoLXVLZBZ+
	un4qp/YFkYkGvPXxjqmIrDQ8n2VGQhGi9B
X-Gm-Gg: AZuq6aJ6+/HOLnvin0VIb10HZjP8JluUWn4V7e+hruvRwhNhoDIZTR3p5Dj5dTu61Gb
	hJNk5gbRpunN7IyUmCdL/se/SMmLgGzS5Dp2KG8iheUayXDrvVKwR0gxEi374l/PNeC/xyLs9s8
	ohPnAbhErQpBcJbGSad7gldWADkEnGloKdQyfF8jVgTsb65DHbO7UouyAbIYgZJrIk3c+mu44vd
	KJFCFE=
X-Received: by 2002:a05:690c:6111:b0:798:27f:8839 with SMTP id 00721157ae682-798027f88edmr27293607b3.49.1771511715401;
        Thu, 19 Feb 2026 06:35:15 -0800 (PST)
X-Received: by 2002:a05:690c:6111:b0:798:27f:8839 with SMTP id
 00721157ae682-798027f88edmr27293087b3.49.1771511714813; Thu, 19 Feb 2026
 06:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com> <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 19 Feb 2026 15:35:03 +0100
X-Gm-Features: AaiRm51Yk51MtFkLMzzNm9UI6iqJ3T9b_dxDZQ4oQ-vg-XKrl3rs7xeprCakWg8
Message-ID: <CAF6piCLzyKzGFHF8BNByg-aJD_E6-oOt8RZ9gBO5C3-ANyDx0Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, linyunsheng@huawei.com, 
	andrew+netdev@lunn.ch, parav@nvidia.com, jasowang@redhat.com, mst@redhat.com, 
	shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259489-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[29];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46BB115F968
X-Rspamd-Action: no action

On 2/16/26 9:51 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Currently, mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
> with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
> valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
> offload to clear the CWR flag. As a result, incoming TCP segments
> may lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
>
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
>
> Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")
>

No empty line after the fixes tag (both here and in the next patch).

/P


