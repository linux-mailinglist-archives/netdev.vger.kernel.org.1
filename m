Return-Path: <netdev+bounces-53553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8805803AB2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C7428147B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAD2557A;
	Mon,  4 Dec 2023 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwXp4hEg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B781CD;
	Mon,  4 Dec 2023 08:47:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so16738215e9.0;
        Mon, 04 Dec 2023 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708434; x=1702313234; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWOXd0c0JR/1qx0WwIuHDwJru90/T3xdDRdBKcpoorQ=;
        b=UwXp4hEgyPofr6oQOLmIg6FUkTfaozDMRo40YwF+siEhRL+9yTSYJIeNdgI6DxryIK
         UvY2k6Ylh9+t1oFoxv8LREBKVf8bcpZaZQ9jHVNmLFKYN5AbtQTDjjgLbD+jNqcEGqwD
         aII+8spRnlc1y+O8v7Xn+P/oUYVZTHZTxBAhjfBaA6PPPL8p23WfG5k/7DMh/SZTKQwc
         nHXY2Qf0tsTSEaaqTZqeXwGovxyUKbYke5QxBp8hfTI9SKFg+KmnvQoY0WgFABo8WmZU
         GikFyoM69wl9uvDDmRgebcXxUMoVB1msPfdrTMH9xIDO3RDQWArkeqe4ih+XpilgkpVK
         IIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708434; x=1702313234;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWOXd0c0JR/1qx0WwIuHDwJru90/T3xdDRdBKcpoorQ=;
        b=D05oy3wBJBksjvwVNXZrHwKblws6eITkzY78X1S90boJesHOJaLl0TdszovMmqLkff
         NHyEPGWljuej+yU1Saim5P+5vV6wEFjkPAhAaf/EPvDnhXYHApNSOM0RwAV4H3tnwwmK
         xXfLf7l50waeV0uYUmIHKPz6I3rOqTFv25du7zkEj7Aa6l7krhqrfYItJOG3iHLriihS
         iw98Zhd/14Bbb1TqWGlTd/qM4BccMFx5mXn4UxLBnnkOejpNrTNoVhAXjVltgUDkjTbQ
         kH9qlpbaEwnYma7rjT/Vzp2lkkPcd1RwYiD9PxX5MpXU63RKXpAh2NcMfZT/F3LOZao1
         F1/Q==
X-Gm-Message-State: AOJu0YweN1KIlnR7o95G5mGMTHOFWhRJ1OadmYwiyvtKqNe/xQkKVwyx
	dNSuPsSsTR1O2nYlFo/mvpI=
X-Google-Smtp-Source: AGHT+IEpHyMQPBhE+mKRc+nSSN2OTrbaim+fbgwW/eS8SzPKILZKx0sKKOIcA+vbzPeipjEAhzLLgQ==
X-Received: by 2002:a05:600c:4f4b:b0:40c:f66:2613 with SMTP id m11-20020a05600c4f4b00b0040c0f662613mr195477wmq.107.1701708433996;
        Mon, 04 Dec 2023 08:47:13 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0040849ce7116sm19370513wmq.43.2023.12.04.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:13 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message'
 support to ynl
In-Reply-To: <20231201181505.002edc7f@kernel.org> (Jakub Kicinski's message of
	"Fri, 1 Dec 2023 18:15:05 -0800")
Date: Mon, 04 Dec 2023 15:54:13 +0000
Message-ID: <m2leaa6k0q.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231201181505.002edc7f@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 30 Nov 2023 21:49:52 +0000 Donald Hunter wrote:
>>  Documentation/netlink/specs/rt_link.yaml |  273 ++-
>>  Documentation/netlink/specs/tc.yaml      | 2008 ++++++++++++++++++++++
>
> Should we add sub-messages to tools/net/ynl/ynl-gen-rst.py ?
> Does the output look sane with the new attributes?

Ah, yes we should. Okay if I look at this as a followup patch?

