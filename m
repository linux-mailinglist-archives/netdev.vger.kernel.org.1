Return-Path: <netdev+bounces-18447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D862B7570BB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 02:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142DC1C20BF1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 00:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE077EA;
	Tue, 18 Jul 2023 00:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948E19C
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:04:35 +0000 (UTC)
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D5FF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:04:32 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-56662adc40bso6740125eaf.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689638672; x=1692230672;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPNHw59Y2ag4IkzmSNpZisnjn27L/MlDJm7h5idWBn8=;
        b=S65TZVHPcH6uRPZb/fHNfGAcZ4q2fX3J8TeaIkzb9hjk1r9RK5GCc7gxTU1gT7BVFb
         2mtAd5EN9chZTfUcFc7hL2MrdAfuUv0ZKe+RCCjPVqIAfcm1rxtQ2Nee3GWXlKLKGvvT
         j0uABVfAF88xKqp15sbUj4Guyba5QkCxOXgSVFDvrttBZVEfL4Gj9ySNzwqjVCdKKVc+
         O3aHFsAlTQIz7RcfgqMhiL0dmlCF+b9PMWN5yevf8JJP30j7wYHo0ofvbJlgfAJTeSC8
         emqYu0USrNG9OIhDCdgyyPcjNH3d9ONnvURLC6m0T2VDt4Y5QkKgBt2JOQgFfe75oSIh
         TSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689638672; x=1692230672;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPNHw59Y2ag4IkzmSNpZisnjn27L/MlDJm7h5idWBn8=;
        b=Nd/MEtvT8FBoMg1W/3EG1v0e9Gass++ZwUGJhtrvyPfygQVnj8V+P3bJKaOInZzzBe
         03WiJxS/+flGaSnrXIUgww76yRF/XjxDmJNTjf4fZ4em9ROAuL9INt5x8KVIdQ2RPp/w
         /0RfikfeVbzYweb89tDAosjdPLB+CgQCEOi+IcMKEIsQO0SHB8iH3yjbAja0ejx8JTtF
         Jc3Wl/AKLFUCUr8G2RZ78RZn8hs7/oEierSoK/BlkW/WWtQHiOes/+wymzHHcAUDJoga
         mMXsFNiWmz9VzbmqyX7yMLeBiQBVjyxCUcFLU93j94gqTIZwcz9PuhB1U4eNW3Fmx6Ma
         C4Yg==
X-Gm-Message-State: ABy/qLYEx5GC08UlFZM/z/gVy5taDumUPK+eZfM+TOyXfuTxX/BaK7VI
	FA5I7+NmSo0IwehszyI9jpL6AEa3BlZ1BPL3dQ==
X-Google-Smtp-Source: APBJJlH9/sYwjrw0dkrjUb9VX/Yq4xUQpwZ/U3IgrKelC5j/eN2Ak33Hd62xQYSUtM5Qs+CsxWEtQXLiE6OotuPBeQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:d0b7:0:b0:547:54e2:688a with SMTP
 id t23-20020a4ad0b7000000b0054754e2688amr613648oor.0.1689638672021; Mon, 17
 Jul 2023 17:04:32 -0700 (PDT)
Date: Tue, 18 Jul 2023 00:04:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAALXtWQC/5WNQQ6DIBBFr2JYlwYYKbar3qNxgTAqSQsGjKkx3
 r3oqps2cXZvkvf+QhJGh4ncioVEnFxywWfgp4KYXvsOqbOZiWACmOKKehypTZqmMXozzLQqS6N
 5PmwEydYQsXXvvfioM/cujSHO+8DEt+/v1sQpp0IoBVLzqwV570Lonng24bW1/4tKGNuW7VVaW x0SNUh1AUAQzcFFUwEY0Fwy9i3W67p+ALpXh7taAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689638671; l=1971;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=4lIe4DSxFXAQphj2dJbrjzQzYQVdZZkIiaZbjRvA4y0=; b=qL/KVpwldCbzLT8NKNpxMObelj3cI09HIcE678bPAe5u640yOLnrfVvF3yT6wO3JK+6CyNe1h
 MsYgBS679IdA4jOGv1+uPHc9bJJ8WOrcQCpXcEPYjQGKWCnJqtfsGoa
X-Mailer: b4 0.12.3
Message-ID: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
Subject: [PATCH] net: dsa: remove deprecated strncpy
From: justinstitt@google.com
To: Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Even call sites utilizing length-bounded destination buffers should
switch over to using `strtomem` or `strtomem_pad`. In this case,
however, the compiler is unable to determine the size of the `data`
buffer which renders `strtomem` unusable. Due to this, `strscpy`
should be used.

It should be noted that most call sites already zero-initialize the
destination buffer. However, I've opted to use `strscpy_pad` to maintain
the same exact behavior that `strncpy` produced (zero-padded tail up to
`len`).

Also see [3].

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: elixir.bootlin.com/linux/v6.3/source/net/ethtool/ioctl.c#L1944
[3]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/dsa/slave.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 527b1d576460..c9f77b7e5895 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1056,10 +1056,10 @@ static void dsa_slave_get_strings(struct net_device *dev,
 	if (stringset == ETH_SS_STATS) {
 		int len = ETH_GSTRING_LEN;
 
-		strncpy(data, "tx_packets", len);
-		strncpy(data + len, "tx_bytes", len);
-		strncpy(data + 2 * len, "rx_packets", len);
-		strncpy(data + 3 * len, "rx_bytes", len);
+		strscpy_pad(data, "tx_packets", len);
+		strscpy_pad(data + len, "tx_bytes", len);
+		strscpy_pad(data + 2 * len, "rx_packets", len);
+		strscpy_pad(data + 3 * len, "rx_bytes", len);
 		if (ds->ops->get_strings)
 			ds->ops->get_strings(ds, dp->index, stringset,
 					     data + 4 * len);

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230717-net-dsa-strncpy-844ca1111eb2

Best regards,
-- 
Justin Stitt <justinstitt@google.com>


