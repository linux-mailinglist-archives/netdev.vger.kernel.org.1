Return-Path: <netdev+bounces-39285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EAF7BEAD3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6642D1C20A11
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F63B7B3;
	Mon,  9 Oct 2023 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e23yKq1w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEE38DCB
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:48:20 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE1A4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:48:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690bd8f89baso3636018b3a.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696880899; x=1697485699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnnGBorqi/0sryABcLeiVXw4usVlXXVKQE9toG3inJM=;
        b=e23yKq1wv/lY0x9LjebsVqZvLDC3yPdbjBtEyEgGrIxa5/qW5r8N3OKAZN6Fe4AI2C
         iBYNB18joJFFK+/Of93yr1coecNoCqRoHQOzFzxtTQvgQzAVc+JKy3yXUm0PscC5TDD8
         VyIz40oa3DURNPKhXQnNorxfjCrCgHOEwuaXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880899; x=1697485699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnnGBorqi/0sryABcLeiVXw4usVlXXVKQE9toG3inJM=;
        b=b6ztR6BJY0f5UsnSPob+NBI3qGcSrPsbNiitfKEtC79uE3CcnYYGTVjuMPzjxv5rEd
         baymuA/luW0lxVdRbxKrM3n9CRL1zEefBwcbFBJTbZ2pjAUz0zp3+iBMGYsMU0/F/kQm
         tkxwLs+DUJP1BmmlymWHJCpJxb9SroEadNpioyupInzWcGqU6IhdKaEZpR7v0d5NKMMK
         eeCppUJyyQQJ9hAqYM2diOKYg1oNUMa/ysKgDxCj/kHaJ7AsbQ88dCcxb1pkr+6KdtRe
         noJ1KoqGm8FKXAPp6rpCRg8K1AczMYlsJs3bYPYYnbDkEwTF/nDMe6yWnPcfAW1P9aB8
         2F0g==
X-Gm-Message-State: AOJu0YxYA48E0VEBXO8aKUP1DA7oF6m8o7FnQjrKJsxEQmrnQG1TtCSd
	iyRPxdIxafSEAGD9dqzr3FQtDw==
X-Google-Smtp-Source: AGHT+IH/EU8sCax66tncCUgtwE24oZqKUnAw5nHePbac/qTNhw0neUzqI+uVELgQYBYwoASCkEKRUQ==
X-Received: by 2002:a05:6a00:1516:b0:691:da6:47b with SMTP id q22-20020a056a00151600b006910da6047bmr16111870pfu.10.1696880898803;
        Mon, 09 Oct 2023 12:48:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn27-20020a056a002fdb00b00688435a9915sm6820661pfb.189.2023.10.09.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:48:18 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:48:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chun-Yi Lee <jlee@suse.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310091246.ED5A2AFB21@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook>
 <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 08:23:08PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
> > On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> >> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> >> 
> >> Sorry, I have to retract this, something went wrong on my
> >> testing and I now see the same problem in some configs regardless
> >> of whether the patch is applied or not.
> >
> > Perhaps turn them into macros instead?
> 
> I just tried that and still see the problem even with the macro,
> so whatever gcc is doing must be a different issue. Maybe it
> has correctly found a codepath that triggers this?
> 
> If you are able to help debug the issue better,
> see these defconfigs for examples:
> 
> https://pastebin.com/raw/pC8Lnrn2
> https://pastebin.com/raw/yb965unC

This seems like a GCC bug. It is complaining about &hdev->bdaddr for
some reason. This silences it:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6f4409b4c364..509e86b36576 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3266,6 +3266,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	int mask = hdev->link_mode;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
+	bdaddr_t a;
 	__u8 flags = 0;
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
@@ -3273,7 +3274,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+	a = hdev->bdaddr;
+	if (!bacmp(&a, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);

:(

-- 
Kees Cook

