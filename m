Return-Path: <netdev+bounces-86642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8489FAFE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF1E1F25201
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707A16D9DC;
	Wed, 10 Apr 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU7C7QJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97F2AF16
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761421; cv=none; b=fSH4zLqvKs0SSsHBQs4hP50zCkKAgTKzbXdLt2Tv5du/bdawO/VRcLbETYrg9hM6cF8nPXxA8pJjnHnABxKUdpr80JGLP+q6ZScT3ov5zrq4ez/a6+ZDGJ3FNbCapjaxassdkA35qSKdcm4LAM9tphSyYYjjTVrE31z5DCX1gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761421; c=relaxed/simple;
	bh=WuJau6EE6vJ0UiHSRal+GPEO+sN19hgYnFyltMuqIPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9EvSHtGqfpucPwk6mnVNQYZzAvMqGEJ53BpL3/y3iLHoh2npFANqxnyOBytAntfNQL7dqziUeM6wd41GC10juxBB8jucB9cKqRZVt0zqUDapQSAGpCXQtWPXnBXFaYCwv0OyoKFTbmSwM4T+ZlXMqml4GgnzVKKgZ1cUhMr850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU7C7QJg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34339f01cd2so5072078f8f.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712761418; x=1713366218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb2/UPCN0uTSL2UqNNurPPQExiIe6+WW1n6ZXerD5kY=;
        b=YU7C7QJgbkY7eAXu2kSE98pG9BUT/47xKBvr7P14qlyYSzZuQB/7rsvXJcLHyJz/1L
         DTjPaVhIXgFlY0FSH5ywnpJoCYoKepUd5Ux1gb5Xfajyx6JD8+YAnXl7F7+/MyYZvLrk
         QkLbplimnJZkXsr4XyWKm9/VUaFfGKULJJ3M1liy+oVEtP+2hqd2Q6bRv9qnx+rhAlZJ
         6ZOfVwAMaCToNaAbIwvk7Nt5is4MOrLSWhvsgInFTYsj9M6NGxJo/fNf7sd1jbvO5II+
         BkIpUirhOwtKokRk2ewYRmL/lQDkzQ/d7h7qrXqOAHD4StCTldbsd2qlkfwXcSaoPFg3
         QL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761418; x=1713366218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb2/UPCN0uTSL2UqNNurPPQExiIe6+WW1n6ZXerD5kY=;
        b=Lh+UFz4cIOw6eK6adriVapcFSj1Hq7mLMYRI7f8ANmley4rpXtGR501dImbRkoBfGx
         RuXRwocc2yBSLqSC2maDwjCqG0q6lCNwBTBu3TySF8npSwDHr6dKSWGNSRZhS96AdOUk
         RpYdjoTNInJY81G9HXPfnApRfcezM4h4hUZBjDrNFFaq4rQV88CpMZv8Gs85K0BPNS7y
         DntVhzSd7yeOhPAlDz+HZmNrO9S4B21YVyPDoEbL9sssSAigttVDq7yy7wbWBGYfelAe
         sUfXR6KiXtMziV2UfYsajtOX5gndiSQjKQiTGEgttr4Azia3jXi8kDgKh5q6+l0Wiq/0
         oaWg==
X-Gm-Message-State: AOJu0Yyl0AfKpDJiD34IGY6CgNDM+eNrrywKTbuDlsjepDzzmdFv34G3
	y/P8qXnt2xc4sog6DaHF2/0rvBj06zDQ3XgMofb15SksYrvPtOrGFEMoF1krUOENEqi9sr8vWF9
	0EKguQWzXHz+LQyuVSFXVVswqB5ZIO0wuOLQ=
X-Google-Smtp-Source: AGHT+IE8pNjrb1JMhkiIKWoykNYphteMxLWmId7exTa7z2fU+QNRRVGOMs+mA+2Jl2IpmI5PjwHrk8Vb1hiJigA5Nmo=
X-Received: by 2002:a5d:6a92:0:b0:345:f08b:a7cb with SMTP id
 s18-20020a5d6a92000000b00345f08ba7cbmr1903559wru.4.1712761417720; Wed, 10 Apr
 2024 08:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
In-Reply-To: <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Apr 2024 08:03:01 -0700
Message-ID: <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:54=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/9 23:08, Alexander Duyck wrote:
> > On Tue, Apr 9, 2024 at 4:47=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/4/4 4:09, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > [...]
> >
> >>> +     /* Unmap and free processed buffers */
> >>> +     if (head0 >=3D 0)
> >>> +             fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
> >>> +     fbnic_fill_bdq(nv, &qt->sub0);
> >>> +
> >>> +     if (head1 >=3D 0)
> >>> +             fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
> >>> +     fbnic_fill_bdq(nv, &qt->sub1);
> >>
> >> I am not sure how complicated the rx handling will be for the advanced
> >> feature. For the current code, for each entry/desc in both qt->sub0 an=
d
> >> qt->sub1 at least need one page, and the page seems to be only used on=
ce
> >> no matter however small the page is used?
> >>
> >> I am assuming you want to do 'tightly optimized' operation for this by
> >> calling page_pool_fragment_page(), but manipulating page->pp_ref_count
> >> directly does not seems to add any value for the current code, but see=
m
> >> to waste a lot of memory by not using the frag API, especially PAGE_SI=
ZE
> >>> 4K?
> >
> > On this hardware both the header and payload buffers are fragmentable.
> > The hardware decides the partitioning and we just follow it. So for
> > example it wouldn't be uncommon to have a jumbo frame split up such
> > that the header is less than 128B plus SKB overhead while the actual
> > data in the payload is just over 1400. So for us fragmenting the pages
> > is a very likely case especially with smaller packets.
>
> I understand that is what you are trying to do, but the code above does
> not seems to match the description, as the fbnic_clean_bdq() and
> fbnic_fill_bdq() are called for qt->sub0 and qt->sub1, so the old pages
> of qt->sub0 and qt->sub1 just cleaned are drained and refill each sub
> with new pages, which does not seems to have any fragmenting?

That is because it is all taken care of by the completion queue. Take
a look in fbnic_pkt_prepare. We are taking the buffer from the header
descriptor and taking a slice out of it there via fbnic_page_pool_get.
Basically we store the fragment count locally in the rx_buf and then
subtract what is leftover when the device is done with it.

> The fragmenting can only happen when there is continuous small packet
> coming from wire so that hw can report the same pg_id for different
> packet with pg_offset before fbnic_clean_bdq() and fbnic_fill_bdq()
> is called? I am not sure how to ensure that considering that we might
> break out of while loop in fbnic_clean_rcq() because of 'packets < budget=
'
> checking.

We don't free the page until we have moved one past it, or the
hardware has indicated it will take no more slices via a PAGE_FIN bit
in the descriptor.

> > It is better for us to optimize for the small packet scenario than
> > optimize for the case where 4K slices are getting taken. That way when
> > we are CPU constrained handling small packets we are the most
> > optimized whereas for the larger frames we can spare a few cycles to
> > account for the extra overhead. The result should be a higher overall
> > packets per second.
>
> The problem is that small packet means low utilization of the bandwidth
> as more bandwidth is used to send header instead of payload that is usefu=
l
> for the user, so the question seems to be how often the small packet is
> seen in the wire?

Very often. Especially when you are running something like servers
where the flow usually consists of an incoming request which is often
only a few hundred bytes, followed by us sending a response which then
leads to a flow of control frames for it.

