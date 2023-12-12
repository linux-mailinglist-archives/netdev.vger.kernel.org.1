Return-Path: <netdev+bounces-56374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C17880EAA4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1031C20BD9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970145D4BF;
	Tue, 12 Dec 2023 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmnPtokq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31AF7;
	Tue, 12 Dec 2023 03:42:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso69684845e9.3;
        Tue, 12 Dec 2023 03:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381370; x=1702986170; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjLS257ANhmVYbZm8dAntJvqdafGsa7RZY8sb6ycf/8=;
        b=HmnPtokqDGnjhKYj0V24tvVnVf3LG7YFcfZfU5AaR5JZ4o2zEWu3VamRToaesz30ge
         0kYLLft7y2wwkxqDHGGLwpqjasELB8764i26mxbES8J9u3/MQv4SdCsvdwrA3qmKxXz1
         tWXJGydKjBMIbIDNsceW10bxtnVWtgPQdLnK/8RVodpjRJaAMuOI3caP42tofz/8VgOb
         QZgUc3b39yF3kPuPVWfhejv9r2w+g/hEU4fLX5cc2AGK7iHST86nPKitt9eXr5Lb4gfC
         957+ZOV19FV4KMvOxzhwx1lFV6bpUGS0vIKvDDP5Lk4I194LGGL+aVLzNo8AwCBHdYCL
         RtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381370; x=1702986170;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjLS257ANhmVYbZm8dAntJvqdafGsa7RZY8sb6ycf/8=;
        b=a/mv9oqKh4I8ephkQwUaxpXGJ/7XjdnEJB1wAcQcsYYo8n7tUrKIiPktUDz4+Ax2gc
         G1Dhl1eS3/w3sUlHe91jaRlQjPoeb4bTXZTMFZQ+AejSFCDiKOIJA64kO23qS5X0t/fZ
         okDf/JtY2gZ2PSewIGdtBxhVEUgXb7JXg4Txe9+BddJHn2ARmtT6UfSEyPQaUcp5DCvJ
         R0/INLgnpFH17yN4WWpn4qilNwZ3LbFlHVh976+w4zAp61/1ikKSp/iIRZ+mJcm4AzA0
         tUuo9+UZaouECMQT6akT7S1av6/b9QcTjKaAj/JTZpQpdAq2v2e34BeqDcJjuTXrIP2D
         iBHQ==
X-Gm-Message-State: AOJu0Yw2ZBgLvEM+oBACGGLm/dKfwkWeJQE0stajPWmk8vukIuNdIMUc
	KSW3bipViZCwZsPXgHvqoOk=
X-Google-Smtp-Source: AGHT+IGhP3G7qleKXca9wFmzUZ2tZ7g4Zwe6JkYwkFgA0X0y88qImkq4412U1LLU5jbByb50SjYnig==
X-Received: by 2002:a05:600c:2047:b0:40c:3dd7:98dc with SMTP id p7-20020a05600c204700b0040c3dd798dcmr2699840wmg.75.1702381369988;
        Tue, 12 Dec 2023 03:42:49 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0040c495b1c90sm5864866wmo.11.2023.12.12.03.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:42:49 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH net-next v2 01/11] tools/net/ynl-gen-rst: Use bullet
 lists for attribute-set entries
In-Reply-To: <20231211152806.42a5323b@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Dec 2023 15:28:06 -0800")
Date: Tue, 12 Dec 2023 11:27:18 +0000
Message-ID: <m2h6kn8xux.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-2-donald.hunter@gmail.com>
	<20231211152806.42a5323b@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Dec 2023 16:40:29 +0000 Donald Hunter wrote:
>> The generated .rst for attribute-sets currently uses a sub-sub-heading
>> for each individual attribute. Change this to use a bullet list the
>> attributes in an attribute-set. It is more compact and readable.
>
> This is on purpose, we want to be able to link to the attributes.
> And AFAIU we can only link to headings.
>
> The documentation for attrs is currently a bit sparse so the docs 
> end up looking awkward. But that's a problem with people not writing
> enough doc comments, not with the render, innit? :(

Okay, then I think we need to try and improve the formatting. Currently
h3 and h4 both have font-size: 130% and the attribute headings get
rendered in bold so they stand out more than the attribute-set headings
they are under. I suggest:

 - Removing the bold markup from the attribute headings
 - Changing h4 to font-size: 110% in sphinx-static/custom.css

That improves things a bit but I feel that the attribute-set headings
still get a bit lost. Not sure if there is anything we can do about
that. The devlink spec is a fairly extreme example because it has a lot
of subset definitions that look especially bleak.

