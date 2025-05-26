Return-Path: <netdev+bounces-193385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DAAC3BC0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9137A8528
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF31DE3DC;
	Mon, 26 May 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lx44D2H9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E919CD0B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248569; cv=none; b=WBaqFYID3yRoVqVrvaPm9RYWWjJcCmiRFjUQY3deUN+UxEdOrLllLImsHeFteeCJMD6sqWbSipZv/QDqls+scU19p+EOlG5UuJYuloR69yNW9xzhRmlLrkSVAAxrfXOF2FZqCWE0Ijlrw0OTYcWEo5sDIsvg98awADYMpk9OIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248569; c=relaxed/simple;
	bh=H6FPcoapW6LYs4/tFMczeQLKOwQR2d+yuZp7FWr7mXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMIejtVjnQ35+rGrHj6kl2N3Sy1iNPn7m2lbhwP1cQCn9khVItdRObq/mHeO5N7EAz+yqbCrUS9sZJ7I9dd4iVQHjmmQcMw120pAt/SG1NndFtQ82LuEkltAhW5+WHTxnu+jzxTqJTEynUk7GwkutM4dV/9LMkcYyRfLaurMbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lx44D2H9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c96759d9dfso342459285a.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748248567; x=1748853367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6FPcoapW6LYs4/tFMczeQLKOwQR2d+yuZp7FWr7mXM=;
        b=Lx44D2H9bleXsznA+xHzyW5XZasHF5bR/HGTZGNGrCXzKH9FVql5fx8FbCDP9yTgNn
         ASjM5PNg8cR5bH8mClbQsy4g9Vy8yRElXLQ7TrFL97QeeM3X+rYQNehbAutCtWJgramz
         9GA+fVSNda5UjezoPAa04mKlRRYDbtbxQEPQGiB+SZppboem/mNrplWcikMelj4VkWk7
         s/9MqBi/G5Nu6x+qH8pYGYXUIt6rnuS0B4Kf98O4r9p5fPnpS3qRaaTE3OYqKo8/LZ5A
         xuViGtO3KewxdiCnhLZjQybb7Y3FXkibO0lsCYeJ6/w75HDVBnohHQl4yejKK5AbqIpQ
         k5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248567; x=1748853367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6FPcoapW6LYs4/tFMczeQLKOwQR2d+yuZp7FWr7mXM=;
        b=SMGguXylMT3H293klIwqdSbcQlBIjzuQdyaFsdEmVH/bxtFo+X8WQco+UbWdHcnna9
         juI8hneIKgMvJGaoF7V0iDY1RgOge0+BeXtDXinxgW+09aMs8rNpfwfAAhYX/0qNkrUR
         N4diQivNGqj6hvPqojGQeLaZ4gFA8r4Dhej95MBLPpfq8OeS+r0vLBlHHsz/JEbgwgGJ
         z4ceEbWgUXcnLGmIbP1ZK4du3iNXn8LVmCn5krIbxDJAciAmwX/HHMozu2vDg73uGyBe
         6D7CVm8rue4ww69SYWqmhgIqGKfTfFgWvSFKfshEbqY34WoTs3X1oi0M0jS2jD+Uzykl
         UfJA==
X-Forwarded-Encrypted: i=1; AJvYcCXgQvSx33XrUsEI383nFcLtMfnA1EM7Vo1OomfI1fGG0jQCZeSGRYTQ0dHASSrotM/W5vvEZZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacRVoCfFmade1S3yPDgEX7eYGzQehyY3fkhKS+ki7WPQt3Lab
	wHZFYv3KMOKVICPntLP2+m3fu/6AKr/TPGw5JbBf5iDHNsAtaeV2YybljjOF9H0zE+mGsdEOP94
	fHSJjqAZ3pk6/acVFRSySu51F1qP1Ae8b5eaAg/Do
X-Gm-Gg: ASbGncsPW1Q/0jjt4lYhQMiqHRoKmhzju/5rN9R0mCaFjkzyHJeGOaBEqqN+gk8K/8z
	U6iiK1QcP7ctrzVs+a3cR0TZEBVRQvdvWtFHWzxAoAGN8igVixRlQAEXtYFS/u2a4xyd8mEFF6f
	OAHehJsYTEwYidf/QvOhCwbKw0pVRui9gKzsWCCSPrpkY=
X-Google-Smtp-Source: AGHT+IH+lATwixyjLk35ENMR/lLPgqnbc0dVWnWlHBmauENi5wzi1s/nKvmOjob9jJmbN2aEHHf1Cbx9zC3cjnzWKgc=
X-Received: by 2002:a05:620a:27c3:b0:7ce:ca97:a6bf with SMTP id
 af79cd13be357-7ceecc166b2mr1460320685a.41.1748248566970; Mon, 26 May 2025
 01:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162746319JPXpL0xRJ-n7onnZApOiV@zte.com.cn>
In-Reply-To: <20250526162746319JPXpL0xRJ-n7onnZApOiV@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 May 2025 01:35:55 -0700
X-Gm-Features: AX0GCFu_RjaFJ93BxZ0dibD3-EVHEhcimUXEfSJZRfc8I1_0AdtDtbR4NXdtp0M
Message-ID: <CANn89i+C-qk-WhEanMS_tRiYJHHixH33MAO3u-wQVdWGJOjskw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: arp: use kfree_skb_reason() in arp_rcv()
To: jiang.kun2@zte.com.cn
Cc: davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, 
	wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn, 
	tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn, 
	ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:27=E2=80=AFAM <jiang.kun2@zte.com.cn> wrote:
>
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>
> Replace kfree_skb() with kfree_skb_reason() in arp_rcv(). Following
> new skb drop reasons are introduced for arp:
>
> /* ARP header hardware address length mismatch */
> SKB_DROP_REASON_ARP_HLEN_MISMATCH
> /* ARP header protocol addresslength is invalid */
> SKB_DROP_REASON_ARP_PLEN_INVALID

Are these errors common enough to get dedicated drop reasons ? Most
stacks have implemented ARP more than 20 years ago.

I think that for rare events like this, the standard call graph should
be plenty enough. (perf record -ag -e skb:kfree_skb)

Otherwise we will get 1000 drop reasons, and the profusion of names
makes them useless.

