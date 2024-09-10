Return-Path: <netdev+bounces-127105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98897422F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A011F261CC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38916F0DC;
	Tue, 10 Sep 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwgej9u6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A71369B6
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993024; cv=none; b=fAmUdsswMZTKPam98gXG7rdhVD85j9/DqbPM9Zpxj9CNqtLzBsHPsPlRsoNfmB1CtbY8ck/zdRMXh96183iT3N3Vs+9Fb/y7SMvm5cc5bapOcisaIkxZKGOCfPl/PDyaeYPvSa4hQ9NDkMO4WV7uUt4J3vFdOQXrG+0Yo2eGavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993024; c=relaxed/simple;
	bh=g3w3Tso/v/0w2ygisx+WBduPcsMuiZqkxxm3w8elGhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMOc6AduJSvjDwN13UM1i/iBQ+58TiAndjxvSkaRJEqRP2ZbjE3OccCixYtwHwKptUoH3Ma0tTXmN2GUVbq0mnL+wJRg39ITgJZJYon6xnXwb2xugnPVfoF1Xwpuuzg7JA1COPdylwQbgYXcESWbT6s86SSTIVi9Gq8TqdwcwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwgej9u6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso570364266b.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725993021; x=1726597821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8v5Hd0GafvR7eRw+F0b/pQqT5Z7153+Dlo66ZdBXwCc=;
        b=fwgej9u6OEaSODOdjmtWHSy36aVJ7bx12nrjcs5c9nia1ycC1CV67feJHQ7FE54lBa
         Fa2cGwt2b5X9C8j78JWoNcbKu1UgzPX4YGOxlku+onfJFRp3vwLVhhlffTyk8aWCwzTf
         8gFHOelzODZFTR1QyS9kS4V45SKB8RBjySgjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993021; x=1726597821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v5Hd0GafvR7eRw+F0b/pQqT5Z7153+Dlo66ZdBXwCc=;
        b=QOkYvJ3dsX+bTfmCESSb54Qxqk6nXprfQ9YdbydtF9qoZH04xdhyq9ttEkZA0FBhDw
         qzPEPA+GC5QMUmwvOQWd2q07X/Z+tqu3o8pO6YvaDO4td94a6+lREGAcQujoBZdRy60J
         qFl3BX0OB3ZcQ3CSOecxOJU9r/R9iZYLnoCvHLPwVPQv6nhzLIFRbVHj8m5iCTJXWc8I
         ZFekdkFNvQuic2Ll9/FacLJJgzYNbQxUchwLRZA4NqZe/IPaVi6m/z2xmJxZ+NTe4u1K
         MRLpxnh5FTxx5KOr/+MDVSjLU6NGoQRi73GSGmSfwqLJA4A2sZlxaKdZWwR6CGz2mWkX
         SNcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpIn72t2HVNECC19KcW2kNtBVUMlkDQnlWuolAvBvCjUtX5lgQ1f5/5m3NSvlOBpBjNQNaUpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5XTvqhuy9Q5c95PBYwYZ1AOuNz+VCq8q/FAhtOuYAPns9Nld
	6/7soc5n2u9fbGevIGPEWxDzk7CRZYq14iMzBlf9a7bewHFMXFT0HFJlawpTVbjafJqWVLWEq3o
	8Qe4=
X-Google-Smtp-Source: AGHT+IF3CSafIdqKzBQ0lFTdu6tLR7xwSIBBGwZYCot0WD0yYR2xHNUP54d66rHsRZpql97Wsko1Ag==
X-Received: by 2002:a17:907:940b:b0:a8b:c9d4:5cef with SMTP id a640c23a62f3a-a8ffab6c98dmr152734466b.29.1725993020288;
        Tue, 10 Sep 2024 11:30:20 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835686sm518540266b.18.2024.09.10.11.30.19
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:30:19 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so6255854a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:30:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbYUYFq6lK6eg8SBK8tzBVBv2dsKswY99d1msiF2YpGVcZ5EviNfMGEHaLPZK6WEIf9OXoGjc=@vger.kernel.org
X-Received: by 2002:a05:6402:34c4:b0:5be:cdaf:1c09 with SMTP id
 4fb4d7f45d1cf-5c3dc7baef3mr12220681a12.28.1725993019011; Tue, 10 Sep 2024
 11:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org> <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
In-Reply-To: <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 10 Sep 2024 11:30:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO9kMbiKLcD3fY0Yt5PJSPD=9NVH0cs=xQFSk8dU9Z1Q@mail.gmail.com>
Message-ID: <CAHk-=wgO9kMbiKLcD3fY0Yt5PJSPD=9NVH0cs=xQFSk8dU9Z1Q@mail.gmail.com>
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Netdev <netdev@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-ide@vger.kernel.org, cassel@kernel.org, handan.babu@oracle.com, 
	djwong@kernel.org, Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 10:53, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit

Just for fun - can you test moving the queue freezing *inside* the
mutex, ie something like

  --- a/block/blk-sysfs.c
  +++ b/block/blk-sysfs.c
  @@ -670,11 +670,11 @@ queue_attr_store(struct kobject *kobj, struct
attribute *attr,
          if (!entry->store)
                  return -EIO;

  -       blk_mq_freeze_queue(q);
          mutex_lock(&q->sysfs_lock);
  +       blk_mq_freeze_queue(q);
          res = entry->store(disk, page, length);
  -       mutex_unlock(&q->sysfs_lock);
          blk_mq_unfreeze_queue(q);
  +       mutex_unlock(&q->sysfs_lock);
          return res;
   }

(Just do it by hand, my patch is whitespace-damaged on purpose -
untested and not well thought through).

Because I'm wondering whether maybe some IO is done under the
sysfs_lock, and then you might have a deadlock?

              Linus

