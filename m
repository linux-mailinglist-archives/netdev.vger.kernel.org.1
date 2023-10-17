Return-Path: <netdev+bounces-41968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C200C7CC768
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E67B20EA9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8044491;
	Tue, 17 Oct 2023 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2RFSKfz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A35EBE
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:26:13 +0000 (UTC)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62429F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:26:11 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-457e5dec94dso1007245137.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697556371; x=1698161171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHINlbXreqE3iQN3eObboINV9WnCejW9vUWn7lGPtlo=;
        b=x2RFSKfzoLhCH973FKvhqMJClk3Sh2RO9syc32hITjxolg7jDRwedWYUCh9AK6mVQD
         cy2oAhnHD1oSSmkCCmx924roWmTBC+uPRN1Notf5q7spebekuZCQ4KmwW8QEpwk3vswr
         eLYTyIyaFA98zJnVai79AOz2CmogzRBQAYV+2I5y9LZ80KVSEBUxQ67HV92GuCp+SaTR
         ZYTJXbc3D/5GSt0sl7Zm3xPGGT0btAdG4cB6g92eerduZ/WPjmurTUWabI+60Rfwf0jd
         XB5d+Un6/Y1yyP399g+KTZ8UakqtmbGocwAbSz3yTy511XIdLg+zqN/Q+bm8kgF+h4qs
         kqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556371; x=1698161171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHINlbXreqE3iQN3eObboINV9WnCejW9vUWn7lGPtlo=;
        b=GF0ThkwyheShKg3t+cSsHmq+t1yEeNGWLzJ2L75+MH5RxHMpltdpL9reOl7I4rEc8e
         J5Vl5p1H2IKNG2GmS5Geh/L00pEG+wkCDOTd4aWqYK2zF6qi494pkNNnAeDO+xX1kz9W
         FP4Qp2nFMhJLDeeAMYx6A0cSnwwzENOzZLXJZnzsMgfl0piXAvagkNSTpDz9JNbLbJXw
         zq32Ch4JL9X5QbB4lqO3Uot39EE/PWAlWLHksghIdKOCiSqAafi1zFjC2xkVC7eV+BqF
         HqhSfGt29tp3TcMalCHSu0IYG/bI7cX2CRxsikilDKatVuV/vytjz+cUIQ69TkQP5oc2
         duFA==
X-Gm-Message-State: AOJu0Yxl7WDJmAeTqMqUfAtcaHEKbMERG3Ulgf/k+zIHVqeB4vv0W3tq
	RW7+i3hmasoxfFu9MGval9k/fB4R0QUYflHL/fgXfQ==
X-Google-Smtp-Source: AGHT+IF1HFES42ATUZepaOpsls79qtYdHeK6asRCTb5G2/b0HZKEhf1uT9VMZPjrKZ+i1a7bBUpKn0uYiTs2oKbr6VY=
X-Received: by 2002:a05:6102:9:b0:457:ddde:ba45 with SMTP id
 j9-20020a056102000900b00457dddeba45mr2822169vsp.14.1697556370826; Tue, 17 Oct
 2023 08:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017124526.4060202-1-edumazet@google.com>
In-Reply-To: <20231017124526.4060202-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 17 Oct 2023 11:25:54 -0400
Message-ID: <CADVnQykHjVfqP75pxOKMAx2q+_n-e1yk8j_xdNKjudG3K6pC5w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tsq: relax tcp_small_queue_check() when rtx
 queue contains a single skb
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 8:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In commit 75eefc6c59fd ("tcp: tsq: add a shortcut in tcp_small_queue_chec=
k()")
> we allowed to send an skb regardless of TSQ limits being hit if rtx queue
> was empty or had a single skb, in order to better fill the pipe
> when/if TX completions were slow.
>
> Then later, commit 75c119afe14f ("tcp: implement rb-tree based
> retransmit queue") accidentally removed the special case for
> one skb in rtx queue.
>
> Stefan Wahren reported a regression in single TCP flow throughput
> using a 100Mbit fec link, starting from commit 65466904b015 ("tcp: adjust
> TSO packet sizes based on min_rtt"). This last commit only made the
> regression more visible, because it locked the TCP flow on a particular
> behavior where TSQ prevented two skbs being pushed downstream,
> adding silences on the wire between each TSO packet.
>
> Many thanks to Stefan for his invaluable help !
>
> Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
> Link: https://lore.kernel.org/netdev/7f31ddc8-9971-495e-a1f6-819df542e0af=
@gmx.net/
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Tested-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thank you to Eric for the nice find and fix, and thank you to Stefan
for the bug report and all the useful testing and data!

neal

