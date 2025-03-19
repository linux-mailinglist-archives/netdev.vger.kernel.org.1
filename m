Return-Path: <netdev+bounces-176151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ACCA691A7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB897AE44D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6D1C726D;
	Wed, 19 Mar 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/CTxrZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0F1B2194;
	Wed, 19 Mar 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395495; cv=none; b=UDYa75TCJAGppD3Jikvv2lzkj704uDhkgP4KK8lfAS3FMMEdLdyGDVG1UEBTYVM3hsr8M89k2BT/xQbTZc6VZexPVLFUnxCGxG196imQLfMgfEhHGzKZ51bUdDRctuJnnFd80vbt0jWprIMdP+3dgr8OZQYI8onh2elIdrOF/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395495; c=relaxed/simple;
	bh=2kUTlgVKdXaU6HebQuUID4h7ToIZ/x1+992oG5ABzDo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kqd0N0LKS5IpsxPZXuaPQlm8LMBqIu88gsr/k6RYAFOrT2mg3/4QFH1HZ6lavwTBYo/VKMwT/sa9i1or0fzKIGqIxfuUF1rr3gusbyeOykIbqSCsWQGmmSjo39YL5dcyj1cuz2vC+HSlhIHJtxOzWwf7Pf9BsrBi79OrW0M6byM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/CTxrZN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46fa764aac2so65542661cf.1;
        Wed, 19 Mar 2025 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395492; x=1743000292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0CLGN5cTlfgjlytu4YISeeqLlzXlwtmuWUtfiJkJb4=;
        b=X/CTxrZNye2hZCD3tG2sJi7O3OTKWVzKKI/EJHZlU1bAp0gRxYGqSg4k7oR2btHIFP
         gGIaTaV/WJX7B5/2AZNjZUsqOr4JghRN3w4dkKPXJsyA/4hPoQAhTUKjwnJizeVPSA3N
         4LNYZheLuipRu3cYUlx+XKBezaU0P+dLBFFU2aAF3ujAscCCxtGT0VmCb2lIeusyM8Ts
         q/TKetpfVHVq2hr5ScmClenmKbF669Rq7+Xxom4SqhaN4arHPWB9eo5iIiMm+pomVudK
         GS5SRchh8NkApOSBpNIBPRWqo5z1MvWd5HeKS2dxQbJ67Egill54LFVrPjlrX5F7cU9I
         9bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395492; x=1743000292;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0CLGN5cTlfgjlytu4YISeeqLlzXlwtmuWUtfiJkJb4=;
        b=SdKBNUwBVSo8xpsE2iVX3LzP4XjxTmkZJQabtSV9P3paR0CI7HiYr6xRdZdLTyBrNG
         zi27tU2HFSFlvShE+P4WvmIcXnHicI4LFjSJHBqzGwDhMCCAWwKY81Siih5bmYeh7h63
         M7QCvIKXXdeiR2MCk1nnZtedlHVu022g2I7k+Xg5Wkot467rwbtXcxyKaLGnAVOx8B5H
         qj1aYIlkAQEQQZ0LAsWXXNVMLKqV2OTn0MukhkMM+Rg6SUeWtvoTfmVnVXeOJ1TX6MVT
         b2XieCH1trwRGs2cZ34BFF+W7bUuz14WfMFSZZstU0VeDq/nVRbnjhk2eR3XH7Qpvcju
         eSCw==
X-Forwarded-Encrypted: i=1; AJvYcCWVDz5N49p6bJ4KShYB6NjGxPEdKKIbUYjF/IErS5H5c7znDB9dONRyelBsYe9PhZagJmIUSJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5tcC4shQkG4eOGtO8YTOrQC2UKHy3gVvU1HD80xGCSf10zND
	mdB4nZsu+WPnVPPX91W7Gr8UMjbdQXkwyHsL8h0d4oeZ4YSQ8HiA
X-Gm-Gg: ASbGncvoZ6yejimao2vyVLImweVX9z3eBrX5sJUcbA61m08/2StZ+fW7go2RaBa/wNs
	P/a+EuNgqveNvkek+yNtnIa35G+ZaPeZ7K1yr28gFfzCJbbEnN2gbPvUTqIUozvAQQHqysY0ybc
	U4VOyuVCUyVmc5wCmTJqKaRKDYPmNZ+nlUzH5czTGamN0F+JHgk9nvK1Dk9jVEq2Bucuq5di+r3
	Sf4lnt0+bzj20N6BVMg7GW6GoBFC3/cXpWCJ0bn0oZboRnVwp/xewyzzCiEmjA2nGpabGWUZyBg
	ll73zLzb/kxtf6Uar7m4mlSw5H3NFxQe+XHxyZGXtjauiIw+pu93/ky1xb2IKMtC0hMgtXIzhL2
	kOpvCxEQIRB7D1iVrdxIqMw==
X-Google-Smtp-Source: AGHT+IGdyQDuFkv49IlOnVToqLS4hx/0uwK7mwDfd+WjK8fKiDRYeRIwJlCvXa8DuS6FGUE+aHxZZg==
X-Received: by 2002:a05:6214:1304:b0:6d8:8d16:7cec with SMTP id 6a1803df08f44-6eb294453fbmr54971966d6.37.1742395492290;
        Wed, 19 Mar 2025 07:44:52 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34d841sm81084846d6.108.2025.03.19.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:44:51 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:44:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
References: <cover.1742324341.git.pav@iki.fi>
 <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION
 timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> >
> > Support enabling TX timestamping for some skbs, and track them until
> > packet completion. Generate software SCM_TSTAMP_COMPLETION when getti=
ng
> > completion report from hardware.
> >
> > Generate software SCM_TSTAMP_SND before sending to driver. Sending fr=
om
> > driver requires changes in the driver API, and drivers mostly are goi=
ng
> > to send the skb immediately.
> >
> > Make the default situation with no COMPLETION TX timestamping more
> > efficient by only counting packets in the queue when there is nothing=
 to
> > track.  When there is something to track, we need to make clones, sin=
ce
> > the driver may modify sent skbs.

Why count packets at all? And if useful separate from completions,
should that be a separate patch?

> > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> > +{
> > +       struct tx_queue *comp =3D &conn->tx_q;
> > +       bool track =3D false;
> > +
> > +       /* Emit SND now, ie. just before sending to driver */
> > +       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_=
SND);
> =

> It's a bit strange that SCM_TSTAMP_SND is under the control of
> SKBTX_SW_TSTAMP. Can we use the same flag for both lines here
> directly? I suppose I would use SKBTX_SW_TSTAMP then.

This is the established behavior.
> =

> > +
> > +       /* COMPLETION tstamp is emitted for tracked skb later in Numb=
er of
> > +        * Completed Packets event. Available only for flow controlle=
d cases.
> > +        *
> > +        * TODO: SCO support without flowctl (needs to be done in dri=
vers)
> > +        */
> > +       switch (conn->type) {
> > +       case ISO_LINK:
> > +       case ACL_LINK:
> > +       case LE_LINK:
> > +               break;
> > +       case SCO_LINK:
> > +       case ESCO_LINK:
> > +               if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
> > +                       return;
> > +               break;
> > +       default:
> > +               return;
> > +       }
> > +
> > +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_=
TSTAMP))
> > +               track =3D true;
> > +
> > +       /* If nothing is tracked, just count extra skbs at the queue =
head */
> > +       if (!track && !comp->tracked) {
> > +               comp->extra++;
> > +               return;
> > +       }
> > +
> > +       if (track) {
> > +               skb =3D skb_clone_sk(skb);
> > +               if (!skb)
> > +                       goto count_only;
> > +
> > +               comp->tracked++;
> > +       } else {
> > +               skb =3D skb_clone(skb, GFP_KERNEL);
> > +               if (!skb)
> > +                       goto count_only;
> > +       }

What is the difference between track and comp->tracked

