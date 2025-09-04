Return-Path: <netdev+bounces-220168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A4B44963
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027991C25C21
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9C2E8B70;
	Thu,  4 Sep 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twm+TTwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F72E88B0;
	Thu,  4 Sep 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024382; cv=none; b=p5C+YXmQlMHOPLxzUBlTz5xoO/2//sqMSi6Dgc5RiEpJe6wYtxrfVEtp1h3SNhMDaRRoL5X2PtRebwLUtmkBLlU+nu5zmrA2CmLACcqDCTpLk5zbiwxHHlLX58iRS41fIAa+6v1V2MErpeP5/5nG7x9LcOMT84ibS6CzZbmxg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024382; c=relaxed/simple;
	bh=ZBR5kYpTew3I7oeoHuGBBXTpnJERsz3BkAbPHFhIm3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHvPeTDAIJWqQzMQdcgO0rhwnVTYM4M2gkclwRyk31gQ4wqu13g83Xs8hBkmd/rghDOLXNjcHvBrPoJh5mSxARui6w2tleiScNKJcfjRsvenLlGvw6YxkxZsxAPX5q7GM1YNRhKDS/0VcTo7K3+p+zxOlpSM5aPRVL5ZEnFFjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twm+TTwe; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603b60cbso15193177b3.1;
        Thu, 04 Sep 2025 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757024380; x=1757629180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBR5kYpTew3I7oeoHuGBBXTpnJERsz3BkAbPHFhIm3s=;
        b=Twm+TTwehZoDQJU+8EW0uJxGaFpjBgYeMTGkdfmXVl67VQeUSrKlSkogrLmT7MWH1j
         FE1fhGkYxmboN9Y5npMmXY9XTd+e92rPfY5aeMUs4MDYCbwgWp3RE611NtEtiPTQL1fz
         JTRoyyhbb4HTn/VOv6bGRM2ZAx30ugnjx3lBZzpi2J26dNJAWFe08/WRyOfuvihrJ+pE
         FCQv+7CSjyB9V3KqX5EFF5PEWEX6W7JdIMdDvHxBHYfMN64t0ZKUG7Rel7bo0sh8Lyas
         iwTxNp5r9u0ZC5Vn0WaQj/AOKjokdhqBs55iLq8jS2sAPlSerWLTzWlxW7XUZ0IVrKvS
         tMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757024380; x=1757629180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBR5kYpTew3I7oeoHuGBBXTpnJERsz3BkAbPHFhIm3s=;
        b=oaLk6NDGzHE/+/KChSbCN/eFgitXurpbtU0bxO5M9dtZ7XI2ivmqDPj1M8IDIKIxjB
         4T9cqZmblHB6mRg5TBk7WW42pZUUEDjCxYeAiawtNWWy+li12KeU7W7xhuo/lPJWnSmE
         VLSbcru5/KUXC5/hcBAzFecKwbZG0FjIYnpjxfknir2GpImxaP1nk44kshpbQF8ljODm
         LsfaZu22OOKo4opznj0RBtFfslHc6jquBRQxmzkiuaVrpCpykKvNbJd83cjJ1P3BhnRs
         sW0RODAZNpo6r5lg/PI1XXRLEcxY3/GsbgLE6ZHF9WdHSBrb0OtQr7CAWTK5zJBGz4Fa
         RenA==
X-Forwarded-Encrypted: i=1; AJvYcCU51XE9uKeYBfaC43Srq0TFnaJnRehbCevR/0LwrzDmQp2ry1oZZh8yOzqubPGB2vqN5nKaj2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFn1E7+uUP+G1sZTMHxxZcQTcif3d7uDgc5uK2VV+4nN41UjM
	dIJXNoPgb/SQ9DwB6v98bySVmrkQzd9sCPAr9I7OtHF8AWtItQLTALRph8XOm9mqggV+g9GM/FX
	px0nArqotGZ4p2Wiqu3IXa+gLSkIYHK5p6g==
X-Gm-Gg: ASbGncuosJ/gUbi3aib6kY9+T8r1cRMUUj7dtYgnIhHVCusP22Oyad1OLFlK752C7Uv
	TWPRW4ipoSs7oHngzgXO0XUF41tBl+0uTzX4643kQ1LemVsj27Ivbz06CBctZAfg7EvroHcyOcd
	eZ3ZMApCW2VOu/+dnWdcYSutKp5iTUqJqjoZJbfu66qlejhlShxcVVXxeMD1uyVyA3F94ojeQyY
	PeYYZrv3+PQnThw2EfKh0uWWNuy
X-Google-Smtp-Source: AGHT+IFzvMrwzdA7gJDCDgmtDNghr3wtpaS8sphzwlvq9gDLtRoDXqEErUssOKB801IFwwXNbDtikby9A5bnM5wi9gk=
X-Received: by 2002:a05:690c:368c:b0:724:72f0:50e7 with SMTP id
 00721157ae682-72472f05357mr54295697b3.3.1757024379750; Thu, 04 Sep 2025
 15:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-3-ameryhung@gmail.com>
 <f35db6aa-ac4c-4690-bb54-4bbd5d4a3970@nvidia.com>
In-Reply-To: <f35db6aa-ac4c-4690-bb54-4bbd5d4a3970@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Sep 2025 15:19:28 -0700
X-Gm-Features: Ac12FXyHH9LbuyPiY7SEBO-92xNqXL_C4OFjwxecf1U9Ww3niI2okXoyg26GQ5Q
Message-ID: <CAMB2axOZW_t1y8_wQN=e-vx1LHWLA-CKnYDjVo_g6FcY9NQ5uA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/7] bpf: Allow bpf_xdp_shrink_data to shrink a
 frag from head and tail
To: Nimrod Oren <noren@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:44=E2=80=AFAM Nimrod Oren <noren@nvidia.com> wrot=
e:
>
> On 25/08/2025 22:39, Amery Hung wrote:
> > Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
> > functionality to be able to shrink an xdp fragment from both head and
> > tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
> > xdp fragment from head.
> I had assumed that XDP multi-buffer frags must always be the same size,
> except for the last one. If that=E2=80=99s the case, shrinking from the h=
ead
> seems to break this rule.

I am not aware of the assumption in the code. Is this documented somewhere?

Thanks,
Amery

