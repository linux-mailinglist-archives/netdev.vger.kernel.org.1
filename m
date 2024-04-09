Return-Path: <netdev+bounces-86197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735DE89DE60
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B203286E19
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351D913D280;
	Tue,  9 Apr 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN+QTtqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8F139D1C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675323; cv=none; b=ATGPdWADAismfqMSQoH/D8QOwsOfXY96AvT+g323bLfA/16e6ySRP1dzTQAJVNQhvy0F6n+IHWy/xzKfQEYcp79w/nHaKo8viUwlsRAAJ6FoIkSe9XGJWXYCV/OuYHaoimgefUIyHjsnMfMLrZH04oExm2cHXIJXKcblHxyYnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675323; c=relaxed/simple;
	bh=ebU8Z7n4Ls7Nr2/Mi0BFQjgzGu7Ggp6Eto+4X5cr/5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2x0jIaKtkpXrbpMxxsXvuX7YzTQ9rubjyIgRlhjH1rMZD8OOY6YDkW8/aDrZPweIrcieuGM6t4u5zSF9g/sDuiS0ux+klL9lbMxK8v1yQqmIaiJ4dlQH20zd/b9CgcH+n+87ApuRk0IsTjT3YKg5pnHopm2l1aCLz6h0zdc4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN+QTtqd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso4172901f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712675320; x=1713280120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRvba/0Q2hV4e82J7nfgk7LJkJSxiZXKb+MkYrq62DY=;
        b=HN+QTtqd1RN39sdaLfxevKLHDdQqWL3FJtVUQkCIJFv+Z5BLXic+Ee9EWgs8JfJ7fB
         yD1RJ/tLgyAqU9BvsGzJnojfD8NjhGUqRoiEMDzzDq3dABMf5Ucg9MVprrLkCVNtL4h1
         u9UF8VLmpqaY3TwhQvj5X1WnlFbEcLsjF+U4w05dFGe2gUrL7HxU0TnbnV1vtjGfi81d
         bpeU7IfV4z90yFR3TniH8nsq9lUvmnim7y0FyFKm9yTSA3jT6G+W6y/FWhs6taNl4acA
         /f4/ph8/X41Scp3wbIyojUJgVsG/WqmrPQXVPGpHYqQSOgWWBBLvtTga+y+r6t7h9c8e
         pyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675320; x=1713280120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRvba/0Q2hV4e82J7nfgk7LJkJSxiZXKb+MkYrq62DY=;
        b=YnG9RS36xJBGPp4IBU47xARSYqmQdfbjktdMLomooSvXUjMLkklO3jhf7F3oS7JKm8
         ULdB6ARsxBZ9ffpon7SK+gG0nenANfPr4/o1afZZaWNhDDBSBOGximz7LVEljIMjXbzC
         CMKJm7RMxAxaO0Og4N9hJD01gWiaTQHJpmHIBNtZHn15YfdcAfs+2iy47czxUCp6OqTY
         D42oP97LeOOzYz/6rUgP3xhYPDYI+uePICdYmTLGEParK72km5QmDK01Qxxng7ECh+Jj
         nYmlFDtUwlonnES+M1wvtLWXWkGwTJOuk0B5WyhW3geFF6TetsNoE6xGqP1YS1VgkLpW
         42xA==
X-Gm-Message-State: AOJu0YyICBlrvL8P59RnV47P1bNKdBGkRI4TFPYt0Gs9iP219cdjJtb/
	d7X9YXS4iuRwNSq5QmZtCIMD3txbBYkOZReHVCYKMUAhiTGjcGnGrn8D0y8gKMhkwKv2Kuj/I5k
	KPkoukut8wUcAslF8KDfRnPdwr9I=
X-Google-Smtp-Source: AGHT+IE4kJMLgFvyq1Kxt3CSftnHHve8APoCXb0yJGaVYltKPEAYEZj4TnNvL7C4o1Z4hjfFJru1ngmdptBTQzcq0oI=
X-Received: by 2002:a05:6000:1a4f:b0:343:7f4b:6da1 with SMTP id
 t15-20020a0560001a4f00b003437f4b6da1mr7352507wry.45.1712675319434; Tue, 09
 Apr 2024 08:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
In-Reply-To: <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 08:08:02 -0700
Message-ID: <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:47=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/4/4 4:09, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>

[...]

> > +     /* Unmap and free processed buffers */
> > +     if (head0 >=3D 0)
> > +             fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
> > +     fbnic_fill_bdq(nv, &qt->sub0);
> > +
> > +     if (head1 >=3D 0)
> > +             fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
> > +     fbnic_fill_bdq(nv, &qt->sub1);
>
> I am not sure how complicated the rx handling will be for the advanced
> feature. For the current code, for each entry/desc in both qt->sub0 and
> qt->sub1 at least need one page, and the page seems to be only used once
> no matter however small the page is used?
>
> I am assuming you want to do 'tightly optimized' operation for this by
> calling page_pool_fragment_page(), but manipulating page->pp_ref_count
> directly does not seems to add any value for the current code, but seem
> to waste a lot of memory by not using the frag API, especially PAGE_SIZE
> > 4K?

On this hardware both the header and payload buffers are fragmentable.
The hardware decides the partitioning and we just follow it. So for
example it wouldn't be uncommon to have a jumbo frame split up such
that the header is less than 128B plus SKB overhead while the actual
data in the payload is just over 1400. So for us fragmenting the pages
is a very likely case especially with smaller packets.

It is better for us to optimize for the small packet scenario than
optimize for the case where 4K slices are getting taken. That way when
we are CPU constrained handling small packets we are the most
optimized whereas for the larger frames we can spare a few cycles to
account for the extra overhead. The result should be a higher overall
packets per second.

