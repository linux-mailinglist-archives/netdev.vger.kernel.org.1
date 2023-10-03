Return-Path: <netdev+bounces-37621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B47B65D2
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A5BAF2815CB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F8101D5;
	Tue,  3 Oct 2023 09:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A8D278
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:47:52 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC120AC
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 02:47:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3248aa5cf4eso762213f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1696326469; x=1696931269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBvKbEN7uDtuFtsxJfRrRjzzGGnFuZYqaHqhGQZidV4=;
        b=RRw/2EUXjV4n0NvsYvJyER6TVTWo1xcYzCxEbyGV+aJym0UQJSmFcCv8Ilz0t3Svdi
         DHXTXkdLNixpmKtdQgJFH9ZjfMdgSFwme6hMoqUenqOGZqiEIEQuxc71fM/Hfn5LuHKq
         tn27aoIlzs0eXWy7aHY4BNThv90wDp43UbycybrADuR129u/RZiwzkfQDnmb0UD3+9/T
         lIlmLeRsTobpCp5v3YLRvMowBSceff7/xGLE56WeiEG7ktc8bes1ifhy1BobYxqaSYwM
         6y3gu1liPRx6B0lMmL1QvP14zXPZWlDjfUzWNVoMZm9ZCvL9eD/sV3saGrQUfgn4aXR4
         XjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326469; x=1696931269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBvKbEN7uDtuFtsxJfRrRjzzGGnFuZYqaHqhGQZidV4=;
        b=dFhvlWk348G7HY5MPZNZ1+40TiVa5HWNj58o6yKULWgZ2x09g4KJuO24cg+3Owlb7w
         M78H/4jPWmJmvQ4JRmEjNjxfdrI2ibP/IBvKBNDy26FUPD4uunshhDFzFMSV0kO3Juei
         I7F8VvStqR8q/mueK3fxtEpnFpFSuxVNHy1KF6PmlGBdbPrLgtpX+5J2bZhDaBdk2YSy
         KFPYbU2bn3GlxWEhkG/Srg/Fok6JmYq0tYmez2NhZPapeXUNkWGimBEp4NyVGHhqbn6v
         KWoMnYeec0y+zig1zXOGHSAV846pwtbfOTI7Dz0iTcNIn1HKJI98hlacg7hsVCUtqGLU
         xt3g==
X-Gm-Message-State: AOJu0YyneJEZ1uaLiSk5lRQtJanXTV1jOC8rILElTEQtx2rMWUlLdptD
	UkcFy4VBMUWC9W8J484fxDbu5w==
X-Google-Smtp-Source: AGHT+IGUh1950pWetTxtx7q83FpbGHfIP2i0XfKIZAsWbMnpPcqsAeocHQgW3JInowayb5Czz7DORQ==
X-Received: by 2002:a05:6000:1085:b0:31f:b9ea:76c with SMTP id y5-20020a056000108500b0031fb9ea076cmr11607118wrw.48.1696326468942;
        Tue, 03 Oct 2023 02:47:48 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cbf:ecfc:277c:2c45? ([2a02:8011:e80c:0:9cbf:ecfc:277c:2c45])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d464e000000b0031f8a59dbeasm1157943wrs.62.2023.10.03.02.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 02:47:48 -0700 (PDT)
Message-ID: <0c000ec4-6522-47b3-accb-e47c985a35ce@isovalent.com>
Date: Tue, 3 Oct 2023 10:47:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
 <20231003093025.475450-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231003093025.475450-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks! Please don't forget to update the version in the titles of the
patches in addition to the cover letter.

On 03/10/2023 10:30, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-cgroup.rst | 16 +++++++++++++---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  8 +++++---
>  tools/bpf/bpftool/bash-completion/bpftool        | 14 +++++++-------
>  tools/bpf/bpftool/cgroup.c                       | 16 +++++++++-------
>  tools/bpf/bpftool/prog.c                         |  7 ++++---
>  5 files changed, 38 insertions(+), 23 deletions(-)

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 8443a149dd17..7ec4f5671e7a 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2475,9 +2475,10 @@ static int do_help(int argc, char **argv)
>  		"                 sk_reuseport | flow_dissector | cgroup/sysctl |\n"
>  		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
>  		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
> -		"                 cgroup/getpeername4 | cgroup/getpeername6 |\n"
> -		"                 cgroup/getsockname4 | cgroup/getsockname6 | cgroup/sendmsg4 |\n"
> -		"                 cgroup/sendmsg6 | cgroup/recvmsg4 | cgroup/recvmsg6 |\n"
> +		"                 cgroup/connect_unix | cgroup/getpeername4 | cgroup/getpeername6 |\n"
> +		"                 cgroup/getpeername_unix | cgroup/getsockname4 | cgroup/getsockname6 |\n"
> +		"                 cgroup/getsockname_unix | cgroup/sendmsg4 | cgroup/sendmsg6 |\n"
> +		"                 cgroup/sendmsg°unix | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsg_unix |\n"


Typo here on "cgroup/sendmsg°unix", please fix it. The rest of the patch
still looks good to me.

Good call from Andrii on the renames, I like it better with "_unix" as
well. :)

