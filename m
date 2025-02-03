Return-Path: <netdev+bounces-162104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D664BA25CB5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1EA1881EEA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F820AF64;
	Mon,  3 Feb 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AhHsSeis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB321171C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592797; cv=none; b=SuHUHki/DUTKpZse0BHkdNsL+p+lh+cLmKzh+QfYq9BRWmM5EIad/cTnnU80b5GI+HX2bEdGR+i8x29+xIKOcYij1OCCJGuC9fQ9g56ftDNuo27nBdJjRmGASRaZuueSD8d6Aj9BwZo0Q6tm2bVz/wrz3rOY2Dbg0mvxRlMPNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592797; c=relaxed/simple;
	bh=Tj7tRy4kZnsxFzQuBtc04+Ahrz10XdqH0zrjX5oVM6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRHnRfRi751IoFETna6CrmTjzQUHv8HpBiweuYPr2xUc+6TU6s9o/GKeZ4WmjaZbENgn/XaHFGNAeuZYQ1NgLfhMt9lBkUOsUyrNqx9u1vkm/TfF9tRixWFrduGuEzgL83YBuSQOqNHYdELaGfEg/8zKn/rFKxdwIds4n1dez+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AhHsSeis; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso967060466b.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738592793; x=1739197593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=AhHsSeisaNRxfF5kpEuWH/NuGkEEpv1vnTj7ov8dvc4SOqrwanUdq0cerpIrAIY5KO
         e0xLN3NncTQKdHp+2y51NgGmv9ulwc6s6YlQvvC8sEwYzXjrmDPfW1P5sJZJVDo2DO7a
         6Lu7iex/hWVl/LNtRHc9nk1a6ySPHTG1l0ZTCGB9wcC1cOHKHvB92C8kPHmpY1ukj9la
         tpeIMaAJAJis7ibRRLXp8njUjDeCMVKXbSKJVW26O/Tr+nSQrg8bmJLV9r5TKEVm9HkD
         0sdyYVw94J5FrQwbw/TXiWME1NugDiPTG57lSyJ2gwt/zJu1Q3tSraQUpYQTCABsq4U6
         osOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592793; x=1739197593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=A7H855xGaoJZjPe3DBt43qa1OA4Eb9lcFruMBRGwlnr/fIqlF4pmTdP1VKG9C3FwY0
         qVhipNiMakjG51vX9rjyuPLx3Qm0OwgNUDYBfzD12gelr/PsBSz3q9+7aju9pJWzLAD2
         hoNsxGHHVb8THjP3CU4mXDF71wt2aigofcNhB5n5MJKsxUz5yH44SPVuto3E+jJa6mfT
         rKr1CxFnzQbjAqJGUj1UElXjD9DUT0aNb+aeynoYvH3OP8rHTTVm2Y0z9/JHN+nFE+jw
         HVskY9jQoqlvuhEcuTvFS9Um8qggjCtoXO2BDOwBDFuEOcIKHkWPRO71UKBRzyxlzrwo
         nHFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7H0tuKaFr0JGw5CtRqueoSmxld4Mn42SYSduXjVlbT4svHZf+18ZqbetnAn1vw1g1aAEO2QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxQJoPi5i8Sp+dfk6MxbHjcUnHM4LgHwMudE51Y08oeg215np
	ifCBBGYgfNtKtay53jqCeRVZSDkEJZBhOo2W8+fxB418zzpjF8kdSNLb68Zw8AM=
X-Gm-Gg: ASbGncsugD3z4nPpBYFQlBMcRqe1kYiVDj7IhAeFXTTexQaAlEDxuD/wj8AehKKznGs
	AS5y1HLiVK1YwYCbZPle0h9oz2JjYYnZW2aMnl4m1r8Db53nVD8MuQawCTGxsjniSGqftrxfIQY
	NLN+9NSon3tIplh8Rbs/ERjJgySu9SGhYmEJKOfq9rsbsi+cSo1RJdrWalYcRdKQetWz3DoxHAs
	XUiFFjuEjq0+ayHbyXqOsocXWyulea70DnHLpSa2LU8aGYUMT+1LYJrkAI7ZxXsQzPtClEmUyqj
	exu5ug==
X-Google-Smtp-Source: AGHT+IEMvqFtWMQcGcbew8g5CbtS87OK4kOUrbaUT5fxc6WJnZS+Qe69TNruF9V9SFX0gjEEIeYYSg==
X-Received: by 2002:a17:907:6eab:b0:ab2:ea29:a2 with SMTP id a640c23a62f3a-ab6cfe11e85mr2509321666b.48.1738592793317;
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab706ce9a53sm509134266b.72.2025.02.03.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Date: Mon, 3 Feb 2025 15:26:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z6DSGOsqjw1ahIYi@tiehlicka>
References: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pwZkf3px21OVJm@tiehlicka>

On Fri 17-01-25 15:59:51, Michal Hocko wrote:
> Hi,
> this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
> find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.
> 
> Please also note you need to fill out the following Google form to
> request attendance and suggest any topics for discussion:
> 
>           https://forms.gle/xXvQicSFeFKjayxB9
> 
> The deadline to do that is Feb 1st!

The deadline has passed but if you forgot or this slipped through then
no worries you can still apply but please do so ASAP. We are going
through all applications these days and will try to send invitations
ASAP so that people can start planning their travel.

Let me also remind that all the topics that are to be scheduled should
be posted to the mailing list (CCing track specific and lsf-pc mailing
lists). 

Let us know if you have any questions!

Thanks!
-- 
Michal Hocko
SUSE Labs

