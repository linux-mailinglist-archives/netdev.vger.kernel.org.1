Return-Path: <netdev+bounces-90727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCA8AFD80
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14441F23AD8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA74A35;
	Wed, 24 Apr 2024 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DcXAARSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B64C9B
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920304; cv=none; b=IkmIxX+Yxn/CeyaNrRq4sMYFTuVHKDUpx3KhENGriReRMy/k07IKESfLtGSAsDIybElmeh4JpM6yJPXBnFnjHxxdj9Mb/T482VteB1eW0Cq/MhwKFbT/xMWB6qc+7HDqyUc3oXz5/G5AJiDA/geB5AtKmgCQODKxomiGdikLnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920304; c=relaxed/simple;
	bh=ly2OjP3OqU6gk7EJTGJpkZfiMl+XfIperBGEh5aHP10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puOpDHPkCZz9feausJ2YZMtYYw4pYIeg4MmIn8dsPGiyxKQZ2t773uOhZ0RecT9fQj5jOriZ3Uc6iWwwXyzurpgnwBuqhuGbxpmAn3k3Ui6kLmVYYpt/nkbqSZYwcCo5dIP3ceYfbSQbHS5Krf9nHazGl3CGPzqWiTqOb0IvqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DcXAARSg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5200202c1bso745152266b.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 17:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713920301; x=1714525101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agi+zB5Y5EOX29+eaFx0fm4Gxy05VBWM+Q41mvlClcY=;
        b=DcXAARSg1koFsGYYZdomuK/vxiwFtjTpnrHxqxYmGhgmd6fil+y/orDzZL0BEN4t6t
         FiWtHOyK8tNM5asmWTjxdkZyyanVfow1iCsLojYyfRfHEA4ASltacJqcbFMltONtsPej
         bBbMb0FE14kgWevxNX2dSH/VZo7jKXznwTUoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713920301; x=1714525101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agi+zB5Y5EOX29+eaFx0fm4Gxy05VBWM+Q41mvlClcY=;
        b=L7cYS15HaiZoWc1mQk8SnJmXV8LRw4dflvmMXveebkuEn4MXOxay3F9lVc5L4MTwLj
         D6ox8ue8bzwQglb3WsrCf9cUdVNYASxNQWCqkv3h+h2iXtIG1mxFNImCb/OY4NSIO3tw
         Jw53A9cp9xxPB63RoZHCkn9XSJxXFEELxeFXIkiCZyg2rDUoxCVlqO8jeA7k2Fm6Yc6T
         6cY6AIU8ISZIXfXRmqJzhITSVADCaHt8zkLHRkXhMpjdmBAUfw8CvPDt2ksYACCHeU5N
         cfMvayZW5CRubYkkWdIutCmq1Xsxy18NKGXlvfqtcYCEBVzrtK1LIq/SjxULhmsdHlMK
         PUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq2Oh2FLCW8Vt8+p/djmm58KPKsJfR7Z1ibRi1OiaLgQ5W1eMewZBFM3cmPI0uRJd+RRJf7a9HOnn6pLO5tBUOxthqhNgd
X-Gm-Message-State: AOJu0YwGxHcAkS3mOJqck8XbLxtZ9bLfibVwGPcAMCrq0wM3jx2RkYvR
	B89ulTp0wfcE+BKrvqEXuPNoBVKvXMlSZdl6axfe6Q7T26Hy2y3cayMCoWtKl82gAxQI/J3ZkcH
	t5rK+egYSxYQLt1vPNGG0kN7ZamgDAMStNi/N
X-Google-Smtp-Source: AGHT+IEr/n+RidcwYYa1O8bUShojVnvd0AdTOnz2UvXoU1pPttFAcg/DZNblCIQjh3OLmIIJ+2Sg7W0GySY7VWJ+psg=
X-Received: by 2002:a17:906:b841:b0:a52:2c4f:7957 with SMTP id
 ga1-20020a170906b84100b00a522c4f7957mr640115ejb.66.1713920300138; Tue, 23 Apr
 2024 17:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424002148.3937059-1-kuba@kernel.org>
In-Reply-To: <20240424002148.3937059-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 23 Apr 2024 17:58:08 -0700
Message-ID: <CACKFLikEhVAJA+osD7UjQNotdGte+fth7zOy7yDdLkTyFk9Pyw@mail.gmail.com>
Subject: Re: [PATCH net] eth: bnxt: fix counting packets discarded due to OOM
 and netpoll
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, edwin.peer@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> I added OOM and netpoll discard counters, naively assuming that
> the cpr pointer is pointing to a common completion ring.
> Turns out that is usually *a* completion ring but not *the*
> completion ring which bnapi->cp_ring points to. bnapi->cp_ring
> is where the stats are read from, so we end up reporting 0
> thru ethtool -S and qstat even though the drop events have happened.
> Make 100% sure we're recording statistics in the correct structure.
>
> Fixes: 907fd4a294db ("bnxt: count discards due to memory allocation error=
s")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Yes, on the newer chips, we have 2 cpr pointers and the correct one
must be used for the sw_stats.  We actually have a patch that changes
cpr->sw_stats to a pointer so that both cpr can share the same
sw_stats structure.  This reminds me to post that patch soon to avoid
this type of confusion in the future.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

