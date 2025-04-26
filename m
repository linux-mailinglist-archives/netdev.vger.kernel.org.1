Return-Path: <netdev+bounces-186279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D2A9DDB5
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 00:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE5A3B5797
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868619DF8B;
	Sat, 26 Apr 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMZtMQfn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06971F19A
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745708189; cv=none; b=s9Pp6kuyEM48bdliTQMACAPTTcq05gfvWWjrXoce3ApvJMV3a/SFIi9049UjFGT5d1qb7DyebS2GWVSlIuMUP+lLEDp2L7lclvMc9nVPC3+AYvqtFgMhR/EUgT2gs6sKxtvbju8Puuf3bSQaUTlVtRJYHsjnsy0FYCRK9gBKeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745708189; c=relaxed/simple;
	bh=mVFdUo6QgWVPWp+kXo87zHfMmgGdAiWN1Y70JHdavPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHB6vy667e+bKErPUyHQUVZjV/yF+fAp/VCsSpY1UeCqkRatoPfdwyFCkX3aCWL69D4p4LVAFBdyjpnoOhpcyVnZikdNXD7UGPBHk/KbmHI864jk/nV82wJZuz6oMLtDvUkJUO12b8m9qiw5J4oC17UFjWksGG3AXNg/yOokf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMZtMQfn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736c277331eso4393263b3a.1
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745708187; x=1746312987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2D2A7P18pCfuq11w3xmiiCk/imi016eB1p6DBZjJM4=;
        b=ZMZtMQfnI61Zs7wcRemz2oHqPstAFOlX6Z2xgI9XD7gMVYHSJo+Z4WQOLsi0jZ5Uia
         a7ZSCc39P3PSi9q+lJDcGhfXGpIbjMzr0DbEtF6xdS0Atwe9EFROYNBrqL0tPYcki7gr
         aGCc3YIty7vgQXFDl725ncubP4E9ouCZML3BKtZyC+VJSeLd+JGK2e3mO9JDKtkCMrRu
         C0Epu+95ejnhEpHVLIp51LNL0lyqmdFa2/RxPDDoKFKr5ivsH9qD4+DBpKdNvDE2sYp8
         exVxRS5uIHG2MoHna3ciUzOYPG53iVAS36k1DZpgQTCPGAVYmcSpUUEBmweoDcP+CQ8f
         ojbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745708187; x=1746312987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2D2A7P18pCfuq11w3xmiiCk/imi016eB1p6DBZjJM4=;
        b=vCYXbHWOSbsTbllZ/L7TdfWIv/oKfJcS/sOTlHSzXBHqsgRJd/8UKQWKoBP5rTi77k
         GkKE5Ko+V8ha8j0ZCYY+3xLKET4y8i3tTVBuZmkiB/PxQbhcVtLbPVSRzY07FcHDMnns
         SRqXBW7grrAyao1Q1jCCYvouoBUJ4M5y5F+c6T2Ww4uIEQmmEtfqgwODAItvUsJozodl
         pBhNiBKnb/gT0URlZEud1K1uH+z3kW9lOv58wlCqZ6am1yk/rr91JsgzKAj2CHE93m/r
         5pFuk1aZEf2bUqoO4pyjwFPfCRqy8KWFXJCv/x/Pc8zoacFb6IJAjrkYIHuk8eTSEIOL
         9MPQ==
X-Gm-Message-State: AOJu0Yz8Z9nkBGEXhgJ8BAkoKumY69wFTs5v4lYCHG+1y9Wy5Cy5ESLS
	VPNsEUKAdXTJAfZ1+UeobcZbNSAj3ZdecaqM5tRcNXRXna7NEhjj
X-Gm-Gg: ASbGncshkc+EW9DqUFykuEdX+0drDtW/pJLFYtcL2RHxbo8QQtKBhIRRNN00lkmNIZV
	N2nyUQ31f1iNB/kB4wNmPgSff2VI4KcMD9aSyS2/LEQS2mOVxnfoeiIJs9LU4Hc030BxAqan4Et
	mpXqSt5/S2UOjL8T/TogWrqEqE+p99L6a9S+DoFyID8Qy2mORJGV9hBov/MyzLXNsWZ/JrVjfla
	492WR9FAJF95hAoacXz4yoWdJS2T3QVhMtmioqFWLMDlXKTgNQhB5YkuRFJUtQm+YK9J7AJXfE+
	wrO3kB6F7lLtOoVw+UgPIoey0WNrQ7f+QU/ijQ20AstHxs/Nhy86BXNDtw==
X-Google-Smtp-Source: AGHT+IHL4Rafna41weaT/pzz1VQHQeYfwrFvuJU5nTp49xcS7190axeh3fqJqKCb4vOTPIlWz5cWgg==
X-Received: by 2002:a05:6a20:3d24:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-2045b5f6042mr7969800637.18.1745708186951;
        Sat, 26 Apr 2025 15:56:26 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:c2d7:f552:ec41:7761])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa80fbaasm4865209a12.49.2025.04.26.15.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 15:56:26 -0700 (PDT)
Date: Sat, 26 Apr 2025 15:56:25 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Will <willsroot@protonmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Savy <savy@syst3mfailure.io>, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [BUG] net/sched: Race Condition and Null Dereference in
 codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <aA1kmZ/Hs0a33l5j@pop-os.localdomain>
References: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com>

Hi Will,

On Fri, Apr 25, 2025 at 02:14:07PM +0000, Will wrote:
> Hi all,
> 
> We've encountered and triaged the following race condition that occurs across 5 different qdiscs: codel, pie, fq_pie, fq_codel, and hhf. It came up on a modified version of Syzkaller we're working on for a research project. It works on upstream (02ddfb981de88a2c15621115dd7be2431252c568), the 6.6 LTS branch, and the 6.1 LTS branch and has existed since at least 2016 (and earlier too for some of the other listed qdiscs): https://github.com/torvalds/linux/commit/2ccccf5fb43ff62b2b9.
> 
> We will take codel_change as the main example here, as the other vulnerable qdiscs change functions follow the same pattern. When the limit changes, the qdisc attempts to shrink the queue size back under the limit: https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_codel.c#L146. However, this is racy against a qdisc's dequeue function. This limit check could pass and the qdisc will attempt to dequeue the head, but the actual qdisc's dequeue function (codel_qdisc_dequeue in this case) could run. This would lead to the dequeued skb being null in the change function when only one packet remains in the queue, so when the function calls qdisc_pkt_len(skb), a null dereference exception would occur.
> 

Thanks for your detailed report, reproducer and patch!

I have two questions here:

1. Why do you say it is racy? We have sch_tree_lock() held when flushing
the packets in the backlog, it should be sufficient to prevent
concurrent ->dequeue().

2. I don't see immediately from your report why we could get a NULL from
__qdisc_dequeue_head(), because unless sch->q.qlen is wrong, we should
always have packets in the queue until we reach 0 (you specifically used
0 as the limit here).

The reason why I am asking is that if we had any of them wrong here, we
would have a biger trouble than just missing a NULL check.


Best regards,
Cong Wang

