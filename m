Return-Path: <netdev+bounces-48312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F667EE055
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C2E280C7D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C982F861;
	Thu, 16 Nov 2023 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5D5BJfY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2129C
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700136307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXjCf62csbMxYH8waOeun5LYImbq0Jl0VT25cr1M6AI=;
	b=f5D5BJfYHuwR1XW7cSf7ZlD0YJXlwCBwIKrIFSY8PwF5E1rfhIRQ2X91X5oggrTSKnQmAB
	o9kDCasyzSmyhvWjLQd4qBQVilAmOfRw/NAnRCv5Smp6py+IDioz/T0wtOPJ4mlDHlJhwq
	YKyl3JC6Cecdc12x+Iy/oRQoJaBO/ag=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-MyMPN7OdN8mKt9r2tcoVXw-1; Thu, 16 Nov 2023 07:05:06 -0500
X-MC-Unique: MyMPN7OdN8mKt9r2tcoVXw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d026cae6eso7645986d6.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 04:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136305; x=1700741105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXjCf62csbMxYH8waOeun5LYImbq0Jl0VT25cr1M6AI=;
        b=dN9ZFnXzgcfiaJdnVcQxaCIbNXCaRYMse3Hq884DD7uC2dHnm8N40DMuXFVktiJ5uf
         xGh3zrHnnI2tli370t5jW+MetkM6bnRIuUT2NyXSxjR/nJiClBtcSfYHb4Zo8LSt/hxv
         EYiYBoOLd6Nu9PpSh9lVTghu49xiS3sDuQ5IIuZokZjAeuKqzBXKKVb2QnT6bXwAIb19
         gq6yCRnJ9Ko0rM7D1nm2WWIARV+gTP0+tx4+1MchGUirSM3bVY6GuqhfMbCSR4b39rFs
         42subBIFOwtgW8LXuqnfAi8Il4epTAsU81MzLcuZGJl83BUzpMm+jIMoxeHERSFB3k4g
         hePw==
X-Gm-Message-State: AOJu0YyaG8SUYDqmkheHMDLUGEwPv3JhWeTvMlXqJQP+foEqDz3EhZCt
	ssBoUN/Ga30gEmKoDyDt3Ox8NWmR6puclvlh77T3/40PCOLvg+Kz4nuj8Fpdencu+isxsEZtLHb
	o0BSd2gToxY69WH6cEvJcTQlK
X-Received: by 2002:ad4:48c2:0:b0:65b:7a2:eecd with SMTP id v2-20020ad448c2000000b0065b07a2eecdmr7634936qvx.61.1700136305623;
        Thu, 16 Nov 2023 04:05:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0nx6R/PtjNTsXH+MHlQqgiHScSQvm+h3pWsUSIvN7cbC4fpaq9LRumIhEBDcIxhqC1SWCMA==
X-Received: by 2002:ad4:48c2:0:b0:65b:7a2:eecd with SMTP id v2-20020ad448c2000000b0065b07a2eecdmr7634924qvx.61.1700136305407;
        Thu, 16 Nov 2023 04:05:05 -0800 (PST)
Received: from localhost ([37.163.136.74])
        by smtp.gmail.com with ESMTPSA id o9-20020ac872c9000000b00419b094537esm4320166qtp.59.2023.11.16.04.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:05:05 -0800 (PST)
Date: Thu, 16 Nov 2023 13:04:59 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: heminhong <heminhong@kylinos.cn>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [PATCH v4] iproute2: prevent memory leak
Message-ID: <ZVYFa5s4l_v4Oz0J@renaissance-vector>
References: <87y1ezwbk8.fsf@nvidia.com>
 <20231116031308.16519-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116031308.16519-1-heminhong@kylinos.cn>

On Thu, Nov 16, 2023 at 11:13:08AM +0800, heminhong wrote:
> When the return value of rtnl_talk() is not less than 0,
> 'answer' will be allocated. The 'answer' should be free
> after using, otherwise it will cause memory leak.
> 
> Signed-off-by: heminhong <heminhong@kylinos.cn>

Reviewed-by: Andrea Claudi <aclaudi@redhat.com>


