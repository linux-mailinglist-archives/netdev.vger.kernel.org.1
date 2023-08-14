Return-Path: <netdev+bounces-27340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D677B860
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCFB1C20A67
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA2BE60;
	Mon, 14 Aug 2023 12:12:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A4BE5F
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:12:01 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C351702
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:12:00 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99bcf3c8524so95441466b.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692015119; x=1692619919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWITk8Z4B3S93bToKNNnplWpD5UoUBOkLNngl+3yGN0=;
        b=VrF+GgBHedJ+VrgKKuhM5G3FLsW1FtXxQURjNWj+LiVaHfdmrfvxIbbr7e5xRhNQ4d
         Ow0Im4aJJjF4vbKfjvVVjj/tfXwidSSTSopGMRGNNLTbyiOzONLWnj2gfgn9nFAKiC9P
         CNgDfiGW0TqqOKZ+7K+iMw7mVJqVuSbvsmmsSy0CpZjTTZm5ZPRUA4IQIyM4nUDjk63O
         bpyL6sxvN+MS3FtIkdIFYRhGtLnzxtHlJM7BHLmnXgjuoniscZns9OeTkDXtEb8qkzv8
         KwbQI6iS+ABoX0hJ7kDhklVoSxYkkjEY1V0A4gugsxdMOIBSarfBSnIW0lHyn9fN2G/l
         NQDA==
X-Gm-Message-State: AOJu0YyXI+NRNaM4U9dbVf6aZxYXpLDjHrMR4dgSxKelcRzvIYCSiZDN
	P3vFPFoyIGTiOwBsjAvqlJE=
X-Google-Smtp-Source: AGHT+IGSXFdwPPy7nFsH9UFmPaGv+ntJuqlBYquqXA4Cmx/Q5yiz0Et8j6euQgn14JCp1XXdjC9R0w==
X-Received: by 2002:a17:906:51cb:b0:99b:d03e:76e8 with SMTP id v11-20020a17090651cb00b0099bd03e76e8mr6386560ejk.5.1692015118554;
        Mon, 14 Aug 2023 05:11:58 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id kd28-20020a17090798dc00b009937e7c4e54sm5646877ejc.39.2023.08.14.05.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:11:58 -0700 (PDT)
Message-ID: <304bc2f7-5f77-6e08-bcdb-f382233f611b@grimberg.me>
Date: Mon, 14 Aug 2023 15:11:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-18-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-18-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Incoming connection might be either 'normal' NVMe-TCP connections
> starting with icreq or TLS handshakes. To ensure that 'normal'
> connections can still be handled we need to peek the first packet
> and only start TLS handshake if it's not an icreq.

That depends if we want to do that.
Why should we let so called normal connections if tls1.3 is
enabled?

