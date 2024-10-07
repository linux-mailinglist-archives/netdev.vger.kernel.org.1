Return-Path: <netdev+bounces-132845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF049936E1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE0F283727
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F061DE3B2;
	Mon,  7 Oct 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js3xa75k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DD1DE3DC;
	Mon,  7 Oct 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327022; cv=none; b=d91lvGQqwi/ks9Wcjq0UbqnAeyjpqtNF2UlGx1TaiXCqGzZbUGUWS1kslpWXPtBJizplBorhdiaRGimC8l0JIxpVs1I3sA1kGT3ggJWUssMWVxLjepn3/KHtd5Yg9a6jb88MA5wpYsFAG4AV5IWcvL0HrelvCONvpBqRQkLvhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327022; c=relaxed/simple;
	bh=OTYr2YeyN6tlmEsUdubvcgRN9nXBDqRzsid4g3QK+gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMwupgdZ2oS3amdQZkx5SBl0Eurd6gYNtNbKPj+qGQdjmGCKCGwvTNcoEZEHujQkoWYkSZAZkNIusJVl/sCviur8FOdsUtJXt2SI7VISOoV0hktdZn2JX4p5jXGXLgkThb0QY1iNur0+zPFdZqPjIciVAZeK1Ce1IfBeOFWHwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js3xa75k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so37955435e9.2;
        Mon, 07 Oct 2024 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728327019; x=1728931819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTYr2YeyN6tlmEsUdubvcgRN9nXBDqRzsid4g3QK+gY=;
        b=Js3xa75kmpvQaV5b5EnBXOgo30yOjUUXZzJQbgHVszru8DlpfjhQjmeqPoOx3GxHAZ
         JaqYTzZbvtMWt4dqBkz02MU9KJwprIazno5fDVBQNsYrodNBeceUTOorkbPbQfr074oF
         wGshxwcy42zDyzx6nHYE5X32O9mw2/r0xtVQOjOr7mJrN+GIALSACdgOOH1Nyr5SNfgS
         3v/Ndupo3pSt808qi13KMkIEMr9ogwJWxdqWI5l905ssuvLaa5BoKen+d1A2yKRTaG09
         j3B3DhxFBlI/1QGOh6PNb1yiOWykfgjxz9MCKxPaLjKrfCmgcSk+QySrom0mDr+b29Yo
         lEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728327019; x=1728931819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTYr2YeyN6tlmEsUdubvcgRN9nXBDqRzsid4g3QK+gY=;
        b=VY+oW9HJwJ+Okerqf5sP7ud5issLMah+aL+FhsE/efhPE5lRoyf+pzcMxH9bXjWfcC
         FSxlno7MqVejs+s1aGsKycZpnWWn/j3RSzJ5+emQzDywo1VIAmvM8oAJ9e+fqIHH03w8
         8HnI0+WwSLAyP4sSWoeiRNikissugHpTOrQARkM+s8hbosboII+4F2kx9Rp9r/vE/P6A
         0CHtH5mA5rFigwqhOqYJYd7RMh6ogNuMBbPQutG/08DdnPLPOSF2LMhr8kPWFsJcr8O+
         lZRduC1+MRI0m4KEhA1Wn+MunV/ux/JC94k6LMDm+lUpnF/9fA9bVCIN/2nXlqpECuyK
         cE9g==
X-Forwarded-Encrypted: i=1; AJvYcCVO3419eNua1E5SoCnoGfk/vAWbLGmhT5xt3TiHdF4gasmjfqCVSDgIAJyYT2KSLsgW4lPAiLE4@vger.kernel.org, AJvYcCWvvXW/qWjufrcyLNWsC8yrsv9RiLF2W2Dzv9axXHnqaZBXDpoJVZXVzcUnmZ/WyOv5eEzkuz2PdbZ2lLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Xm4tQJb2F9Dvne2XmR+QlZMRc74y5DxZ1w3NpG6nJh8sAQ0D
	Kg8aJcKSNQAR4BgN0fB+fAhgJUXcZyMOYBhQjqvzjiKetfjc3+wPmypPj4UTO1R1EmAl2LESwhw
	bhm/954ZPj+I+JluamrCuNA5enIE=
X-Google-Smtp-Source: AGHT+IHXPX/Ep/NBLa02S0kuubhhcF9yvuM6iCmzjgSdT95cFikVa6mIkvCw3Xn56dL0pU0xtclJ78y5vnSb+Zdq4No=
X-Received: by 2002:a05:600c:3b9c:b0:426:593c:935d with SMTP id
 5b1f17b1804b1-42f85aa1a32mr93478785e9.5.1728327019299; Mon, 07 Oct 2024
 11:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001075858.48936-1-linyunsheng@huawei.com>
 <20241001075858.48936-10-linyunsheng@huawei.com> <CAKgT0UeSbXTXoOuTZS918pZQcCVZBXiTseN-NUBTGt71ctQ2Vw@mail.gmail.com>
 <c9860411-fa9c-4e1b-bca2-a10e6737f9b0@gmail.com> <CAKgT0UfY5JtfqsFUG-Cj6ZkOOiWFWJ3w9=35c6c0QWbktKbvLg@mail.gmail.com>
 <218513be-857b-4457-8bd8-c12e170233b7@gmail.com>
In-Reply-To: <218513be-857b-4457-8bd8-c12e170233b7@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 7 Oct 2024 11:49:41 -0700
Message-ID: <CAKgT0Ue=tX+hKWiXQaM-6ypZ8fGvcUagGKfVrNGtRHVuhMX80g@mail.gmail.com>
Subject: Re: [PATCH net-next v19 09/14] net: rename skb_copy_to_page_nocache() helper
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yunsheng Lin <linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:29=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 10/7/2024 12:18 AM, Alexander Duyck wrote:
>
> ...
>
> >
> > I could probably live with sk_copy_to_skb_data_nocache since we also
> > refer to the section after the page section with data_len. The basic
> > idea is we are wanting to define what the function does with the
> > function name rather than just report the arguments it is accepting.
>
> Yes, looking more closely:
> skb_add_data_nocache() does memcpy'ing to skb->data and update skb->len
> only by calling skb_put(), and skb_copy_to_page_nocache() does
> memcpy'ing to skb frag by updating both skb->len and skb->data_len
> through the calling of skb_len_add().
>
> Perhaps skb_add_frag_nocache() might seems a better name for now, and
> the 'sk_' prefix might be done in the future if it does make sense.

That works for me.

