Return-Path: <netdev+bounces-51280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315437F9F10
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC93281564
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297E1E531;
	Mon, 27 Nov 2023 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgbicCmJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EB18A
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701086023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dFDcEA9Z7jcvOeDtvs4nt1f6dFZbdEOKwzb8RSGdjs=;
	b=hgbicCmJF5CW/KGwtzbaWB4Ua/mOkGjDrECL+uGRCaD/qBQBUpuD4STlc0t7XnddDqirIn
	dyCeq4OrN+2IcMbIck7DwfOuLc4XFqTpdq80qfdBpUbSQh5CuvBQt9tHMNDMMTdWUOrtlt
	eyd+JMiRbyEAUPzRdZF9/QDnFha7l3s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-VT_3Y_ZfPXubGWanIvlLxw-1; Mon, 27 Nov 2023 06:53:42 -0500
X-MC-Unique: VT_3Y_ZfPXubGWanIvlLxw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a043b44aec3so84879366b.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701086021; x=1701690821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dFDcEA9Z7jcvOeDtvs4nt1f6dFZbdEOKwzb8RSGdjs=;
        b=bJ/Xb637al+EU028U/Uaajeu+hJD2s9DLI8gQWNjtKz7ENDnTRtMgi20OnEJ8pgM/X
         /vUgutvuqZFQm7IWE6thDqwxwEDiw5P3qYYL6B5FkZJlYLCub6QP1dxrWGs0QBEFZDIp
         /fBvBbsNaaWEf+C7dpol2dJLg8ebs10736PPRJgbTjRLDiM1o/8eO/k70ax8YAkpbw3s
         Z7Fs/eYy5xeZLE8i9OH7ifRkTuUtYIqPU/uOTSMWML81SmZafOmVXjg59MlFOC+pHNSn
         MludEblMeBaIREOPFygtJKZDhZOa3MUJ4MLoon3KP/zRoDVVxWhH6mVTCBzQBOYuZ4wS
         x1ww==
X-Gm-Message-State: AOJu0YwH3cyUuszIQe4DkGNzFdI96TD8ejM4sg2rgRMV27qJxmFNoaOd
	1lfg/G64n/VX0AJXFvlZlF+070mv3YoFjR1qHKtmd3kkC54SjSv+LBfSd9VF/fXx168ie8wkhFH
	Z9plZ16PZiyEQjmT8
X-Received: by 2002:a17:906:c30c:b0:a04:9f07:cb7 with SMTP id s12-20020a170906c30c00b00a049f070cb7mr7102997ejz.2.1701086020797;
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMhVv3wMdQRPOR1xkomAIWGJ5bbogBeJn6ZTccLM2kT5Zm2YVoX1QPW5+GpEUs9yK0xrOnuA==
X-Received: by 2002:a17:906:c30c:b0:a04:9f07:cb7 with SMTP id s12-20020a170906c30c00b00a049f070cb7mr7102969ejz.2.1701086020387;
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id bu8-20020a170906a14800b009e505954becsm5617452ejb.107.2023.11.27.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
Message-ID: <1cdb1f702ba74e42c09f6f6b6ff2ca223ccca14f.camel@redhat.com>
Subject: Re: [PATCH] net :mana :Add remaining GDMA stats for MANA to ethtool
From: Paolo Abeni <pabeni@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Ajay Sharma <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,  Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mikelley@microsoft.com>,  Shradha Gupta <shradhagupta@microsoft.com>
Date: Mon, 27 Nov 2023 12:53:38 +0100
In-Reply-To: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
References: 
	<1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2023-11-24 at 05:02 -0800, Shradha Gupta wrote:
> Extend performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include all GDMA stat counter.
>=20
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

For the next submission, please remember to include the target tree in
the subj prefix:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/mainta=
iner-netdev.rst#L12

(in this case 'net-next').

No additional actions needed here.

Cheers,

Paolo


